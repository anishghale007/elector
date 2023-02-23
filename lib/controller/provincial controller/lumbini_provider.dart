import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lumbiniProvider = Provider.autoDispose((ref) => LumbiniProvider());
final lumbiniFPTPProvider =
StreamProvider.autoDispose((ref) => LumbiniProvider().getFPTPStream());
final lumbiniFptpSortedProvider = StreamProvider.autoDispose(
        (ref) => LumbiniProvider().getSortedFPTPStream());
final lumbiniPRProvider =
StreamProvider.autoDispose((ref) => LumbiniProvider().getPRStream());
final lumbiniPrSortedProvider =
StreamProvider.autoDispose((ref) => LumbiniProvider().getSortedPRStream());



class LumbiniProvider {
  CollectionReference dbLumbiniFPTP =
  FirebaseFirestore.instance.collection('lumbini fptp');
  CollectionReference dbLumbiniPR =
  FirebaseFirestore.instance.collection('lumbini pr');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProvincialFPTP>> getFPTPStream() {
    return dbLumbiniFPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<ProvincialFPTP>> getSortedFPTPStream() {
    return dbLumbiniFPTP
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
      await dbLumbiniFPTP.doc(postId).update({
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
    return _firebaseFirestore.collection('lumbini fptp').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Proportional Voting

  Stream<List<ProvincialPR>> getPRStream() {
    return dbLumbiniPR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<ProvincialPR>> getSortedPRStream() {
    return dbLumbiniPR
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
      await dbLumbiniPR.doc(postId).update({
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
    return _firebaseFirestore.collection('lumbini pr').get().then(
            (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
            ProvincialPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }
}
