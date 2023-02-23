import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final province1Provider = Provider.autoDispose((ref) => Province1Provider());
final province1FPTPProvider =
    StreamProvider.autoDispose((ref) => Province1Provider().getFPTPStream());
final province1FptpSortedProvider = StreamProvider.autoDispose(
        (ref) => Province1Provider().getSortedFPTPStream());
final province1PRProvider =
    StreamProvider.autoDispose((ref) => Province1Provider().getPRStream());
final province1PrSortedProvider =
StreamProvider.autoDispose((ref) => Province1Provider().getSortedPRStream());

class Province1Provider {
  CollectionReference dbProvince1FPTP =
      FirebaseFirestore.instance.collection('province 1 fptp');
  CollectionReference dbProvince1PR =
  FirebaseFirestore.instance.collection('province 1 pr');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProvincialFPTP>> getFPTPStream() {
    return dbProvince1FPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<ProvincialFPTP>> getSortedFPTPStream() {
    return dbProvince1FPTP
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
      await dbProvince1FPTP.doc(postId).update({
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
    return _firebaseFirestore.collection('province 1 fptp').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Proportional Voting

  Stream<List<ProvincialPR>> getPRStream() {
    return dbProvince1PR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<ProvincialPR>> getSortedPRStream() {
    return dbProvince1PR
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
      await dbProvince1PR.doc(postId).update({
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
    return _firebaseFirestore.collection('province 1 pr').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

}
