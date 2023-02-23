import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final madheshProvider = Provider.autoDispose((ref) => MadheshProvider());
final madheshFPTPProvider =
    StreamProvider.autoDispose((ref) => MadheshProvider().getFPTPStream());
final madheshFptpSortedProvider = StreamProvider.autoDispose(
        (ref) => MadheshProvider().getSortedFPTPStream());
final madheshPRProvider =
    StreamProvider.autoDispose((ref) => MadheshProvider().getPRStream());
final madheshPrSortedProvider =
StreamProvider.autoDispose((ref) => MadheshProvider().getSortedPRStream());

class MadheshProvider {
  CollectionReference dbMadheshFPTP =
      FirebaseFirestore.instance.collection('madhesh fptp');
  CollectionReference dbMadheshPR =
  FirebaseFirestore.instance.collection('madhesh pr');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProvincialFPTP>> getFPTPStream() {
    return dbMadheshFPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<ProvincialFPTP>> getSortedFPTPStream() {
    return dbMadheshFPTP
        .orderBy('votes.vote', descending: true)
        .snapshots()
        .map((event) => getFPTPData(event));
  }

  List<ProvincialFPTP> getFPTPData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return ProvincialFPTP(
        id: e.id,
        candidateName: json['candidateName'],
        candidateInfo: json['candidateInfo'],
        partyName: json['partyName'],
        partyUrl: json['partyUrl'],
        imageUrl: json['imageUrl'],
        voteData: Vote.fromJson(json['votes']),
      );
    }).toList();
  }

  Future<void> addFPTPVote(String postId, String userId) async {
    try {
      await dbMadheshFPTP.doc(postId).update({
        'votes': {
          'vote': FieldValue.increment(1),
          'usernames': FieldValue.arrayUnion([userId])
        }
      });
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Future<List<ProvincialFPTPStats>> getProvincialFPTPStats() {
    return _firebaseFirestore.collection('madhesh fptp').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Proportional Voting

  Stream<List<ProvincialPR>> getPRStream() {
    return dbMadheshPR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<ProvincialPR>> getSortedPRStream() {
    return dbMadheshPR
        .orderBy('votes.vote', descending: true)
        .snapshots()
        .map((event) => getPRData(event));
  }

  List<ProvincialPR> getPRData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return ProvincialPR(
        id: e.id,
        partyName: json['partyName'],
        partyInfo: json['partyInfo'],
        imageUrl: json['imageUrl'],
        voteData: Vote.fromJson(json['votes']),
      );
    }).toList();
  }

  Future<void> addPRVote(String userId, String postId) async {
    try {
      await dbMadheshPR.doc(postId).update({
        'votes': {
          'vote': FieldValue.increment(1),
          'userId': FieldValue.arrayUnion([userId])
        }
      });
    } on FirebaseException catch (err) {
      print(err);
    }
  }

  Future<List<ProvincialPRStats>> getProvincialPRtats() {
    return _firebaseFirestore.collection('madhesh pr').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }
}
