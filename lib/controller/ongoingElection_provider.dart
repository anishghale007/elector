import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/ongoing_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ongoingProvider =
    Provider.autoDispose((ref) => OngoingElectionProvider());
final ongoingElectionProvider =
    StreamProvider.autoDispose((ref) => OngoingElectionProvider().getData());
final ongoingTotalVotesProvider =
StreamProvider.autoDispose((ref) => OngoingElectionProvider().getTotalVotes());
final ongoingProvincialTotalVotesProvider =
StreamProvider.autoDispose((ref) => OngoingElectionProvider().getProvincialTotalVotes());

class OngoingElectionProvider {
  CollectionReference dbOngoingElection =
      FirebaseFirestore.instance.collection('ongoing election');

  List<OngoingElection> getOngoingElectionData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return OngoingElection(
        id: e.id,
        electionType: json['electionType'],
        candidates: json['candidates'],
        startDate: json['startDate'],
        startTime: json['startTime'],
        endDate: json['endDate'],
        endTime: json['endTime'],
        canVote: json['canVote'],
        totalVote: json['totalVote'],
        voterId: ((json['voterID'] ?? []) as List)
            .map((e) => (e as String))
            .toList(),
      );
    }).toList();
  }

  Stream<List<OngoingElection>> getData() {
    return dbOngoingElection
        .snapshots()
        .map((event) => getOngoingElectionData(event));
  }

  OngoingElectionSingle ongoingElection(QuerySnapshot querySnapshot) {
    final singleData = querySnapshot.docs[0].data() as Map<String, dynamic>;
    return OngoingElectionSingle.fromJson(singleData);
  }

  Stream<OngoingElectionSingle> getTotalVotes() {
    final totalVote = dbOngoingElection.where('electionType', isEqualTo: "Federal Election").snapshots();
    return totalVote.map((event) => ongoingElection(event));
  }

  Stream<OngoingElectionSingle> getProvincialTotalVotes() {
    final totalVote = dbOngoingElection.where('electionType', isEqualTo: "Provincial Election").snapshots();
    return totalVote.map((event) => ongoingElection(event));
  }

  Future<void> addUserID(String postId, String userId) async {
    try {
      await dbOngoingElection.doc(postId).update({
        'voterID': FieldValue.arrayUnion([userId]),
        'totalVote': FieldValue.increment(1),
      });
    } on FirebaseException catch (err) {
      print(err);
    }
  }
}
