import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final karnaliProvider = Provider.autoDispose((ref) => KarnaliProvider());
final karnaliFPTPProvider =
    StreamProvider.autoDispose((ref) => KarnaliProvider().getFPTPStream());
final karnaliFptpSortedProvider = StreamProvider.autoDispose(
    (ref) => KarnaliProvider().getSortedFPTPStream());
final karnaliPRProvider =
    StreamProvider.autoDispose((ref) => KarnaliProvider().getPRStream());
final karnaliPrSortedProvider =
    StreamProvider.autoDispose((ref) => KarnaliProvider().getSortedPRStream());

class KarnaliProvider {
  CollectionReference dbKarnaliFPTP =
      FirebaseFirestore.instance.collection('karnali fptp');
  CollectionReference dbKarnaliPR =
      FirebaseFirestore.instance.collection('karnali pr');
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProvincialFPTP>> getFPTPStream() {
    return dbKarnaliFPTP.snapshots().map((event) => getFPTPData(event));
  }

  Stream<List<ProvincialFPTP>> getSortedFPTPStream() {
    return dbKarnaliFPTP
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
      await dbKarnaliFPTP.doc(postId).update({
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
    return _firebaseFirestore.collection('karnali fptp').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                ProvincialFPTPStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  // Proportional Voting

  Stream<List<ProvincialPR>> getPRStream() {
    return dbKarnaliPR.snapshots().map((event) => getPRData(event));
  }

  Stream<List<ProvincialPR>> getSortedPRStream() {
    return dbKarnaliPR
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
      await dbKarnaliPR.doc(postId).update({
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
    return _firebaseFirestore.collection('karnali pr').get().then(
        (querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) =>
                ProvincialPRStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }
}
