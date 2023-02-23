import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/federal_election.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final federalProvider = Provider.autoDispose((ref) => FederalProvider());
final fptpProvider =
    StreamProvider.autoDispose((ref) => FederalProvider().getFPTPStream());
final fptpSortedProvider = StreamProvider.autoDispose(
    (ref) => FederalProvider().getSortedFPTPStream());
final prProvider =
    StreamProvider.autoDispose((ref) => FederalProvider().getPRStream());
final prSortedProvider =
    StreamProvider.autoDispose((ref) => FederalProvider().getSortedPRStream());

class FederalProvider {
  CollectionReference dbFederalFPTP =
      FirebaseFirestore.instance.collection('federal fptp');
  CollectionReference dbFederalPR =
      FirebaseFirestore.instance.collection('federal pr');

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<FederalFPTP>> getFPTPStream() {
    return dbFederalFPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<FederalFPTP>> getSortedFPTPStream() {
    return dbFederalFPTP
        .orderBy('votes.vote', descending: true)
        .snapshots()
        .map((event) => getFPTPData(event));
  }

  List<FederalFPTP> getFPTPData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return FederalFPTP(
        id: e.id,
        candidateName: json['candidateName'],
        candidateInfo: json['candidateInfo'],
        partyName: json['partyName'],
        partyUrl: json['partyUrl'],
        imageUrl: json['imageUrl'],
        barColor: json['barColor'],
        voteData: Vote.fromJson(json['votes']),
      );
    }).toList();
  }

  Future<void> addFPTPVote(String postId, String userId) async {
    try {
      await dbFederalFPTP.doc(postId).update({
        'votes': {
          'vote': FieldValue.increment(1),
          'usernames': FieldValue.arrayUnion([userId])
        }
      });
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Future<List<FederalFPTPStats>> getFederalFPTPStats() {
    return _firebaseFirestore.collection('federal fptp').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                FederalFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Federal Proportional Voting

  Stream<List<FederalPR>> getPRStream() {
    return dbFederalPR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<FederalPR>> getSortedPRStream() {
    return dbFederalPR
        .orderBy('votes.vote', descending: true)
        .snapshots()
        .map((event) => getPRData(event));
  }

  List<FederalPR> getPRData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return FederalPR(
        id: e.id,
        partyName: json['partyName'],
        partyFull: json['partyFull'],
        partyInfo: json['partyInfo'],
        barColor: json['barColor'],
        imageUrl: json['imageUrl'],
        voteData: Vote.fromJson(json['votes']),
      );
    }).toList();
  }

  Future<void> addPRVote(String userId, String postId) async {
    try {
      await dbFederalPR.doc(postId).update({
        'votes': {
          'vote': FieldValue.increment(1),
          'userId': FieldValue.arrayUnion([userId])
        }
      });
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Future<List<FederalPRStats>> getFederalPRtats() {
    return _firebaseFirestore.collection('federal pr').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) => FederalPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }
}
