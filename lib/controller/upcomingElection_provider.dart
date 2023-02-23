import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/models/upcoming_election.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final upcomingElectionProvider =
    StreamProvider.autoDispose((ref) => UpcomingElectionProvider().getData());

class UpcomingElectionProvider {
  CollectionReference dbUpcomingElection =
      FirebaseFirestore.instance.collection('upcoming election');

  List<UpcomingElection> getUpcomingElectionData(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((e) {
      final json = e.data() as Map<String, dynamic>;
      return UpcomingElection(
        day: json['day'],
        month: json['month'],
        electionType: json['electionType'],
        startDate: json['startDate'],
        startTime: json['startTime'],
      );
    }).toList();
  }

  Stream<List<UpcomingElection>> getData() {
    return dbUpcomingElection
        .snapshots()
        .map((event) => getUpcomingElectionData(event));
  }
}
