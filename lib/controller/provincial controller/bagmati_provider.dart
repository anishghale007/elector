import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bagmatiProvider = Provider.autoDispose((ref) => BagmatiProvider());
final bagmatiFPTPProvider =
    StreamProvider.autoDispose((ref) => BagmatiProvider().getFPTPStream());
final bagmatiFptpSortedProvider = StreamProvider.autoDispose(
    (ref) => BagmatiProvider().getSortedFPTPStream());
final bagmatiPRProvider =
    StreamProvider.autoDispose((ref) => BagmatiProvider().getPRStream());
final bagmatiPrSortedProvider =
    StreamProvider.autoDispose((ref) => BagmatiProvider().getSortedPRStream());

class BagmatiProvider {
  CollectionReference dbBagmatiFPTP =
      FirebaseFirestore.instance.collection('bagmati fptp');
  CollectionReference dbBagmatiPR =
      FirebaseFirestore.instance.collection('bagmati pr');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProvincialFPTP>> getFPTPStream() {
    return dbBagmatiFPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<ProvincialFPTP>> getSortedFPTPStream() {
    return dbBagmatiFPTP
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
      await dbBagmatiFPTP.doc(postId).update({
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
    return _firebaseFirestore.collection('bagmati fptp').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                ProvincialFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Proportional Voting

  Stream<List<ProvincialPR>> getPRStream() {
    return dbBagmatiPR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<ProvincialPR>> getSortedPRStream() {
    return dbBagmatiPR
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
      await dbBagmatiPR.doc(postId).update({
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
    return _firebaseFirestore.collection('bagmati pr').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                ProvincialPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }
}
