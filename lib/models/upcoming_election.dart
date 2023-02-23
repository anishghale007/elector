import 'package:cloud_firestore/cloud_firestore.dart';


class UpcomingElection {
  late String day;
  late String month;
  late String electionType;
  late String startDate;
  late String startTime;

  UpcomingElection({
    required this.day,
    required this.month,
    required this.electionType,
    required this.startDate,
    required this.startTime,
  });
}
