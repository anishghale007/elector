import 'package:cloud_firestore/cloud_firestore.dart';


class FederalFPTP {
  late String id;
  late String candidateName;
  late String candidateInfo;
  late String partyName;
  late String imageUrl;
  late String partyUrl;
  late String barColor;
  late Vote voteData;

  FederalFPTP({
    required this.id,
    required this.candidateName,
    required this.candidateInfo,
    required this.partyName,
    required this.partyUrl,
    required this.imageUrl,
    required this.barColor,
    required this.voteData,
  });

  factory FederalFPTP.fromJson(Map<String, dynamic> json) {
    return FederalFPTP(
        id: json['id'],
        candidateName: json['candidateName'],
        candidateInfo: json['candidateInfo'],
        partyName: json['partyName'],
        partyUrl: json['partyUrl'],
        imageUrl: json['imageUrl'],
        barColor: json['barColor'],
        voteData: Vote.fromJson(json['votes']),
    );
  }

}

class FederalFPTPStats{
  final int index;
  final String candidateName;
  final Vote voteData;
  final String barColor;


  FederalFPTPStats({
    required this.candidateName,
    required this.voteData,
    required this.index,
    required this.barColor,
});


  factory FederalFPTPStats.fromSnapshot(DocumentSnapshot snap, int index) {
    return FederalFPTPStats(
      index: index,
      candidateName: snap['candidateName'],
      barColor: snap['barColor'],
      voteData: Vote.fromJson(snap['votes']),
    );
  }

}

/////////////////// FEDERAL PR ////////////////////

class FederalPR {

  late String id;
  late String partyName;
  late String partyFull;
  late String partyInfo;
  late String imageUrl;
  late String barColor;
  late Vote voteData;

  FederalPR({
    required this.id,
    required this.partyName,
    required this.partyFull,
    required this.partyInfo,
    required this.imageUrl,
    required this.barColor,
    required this.voteData,
});

}

class FederalPRStats {
  final int index;
  final String partyName;
  final String barColor;
  final Vote voteData;

  FederalPRStats({
    required this.index,
    required this.partyName,
    required this.barColor,
    required this.voteData,
});

  factory FederalPRStats.fromSnapshot(DocumentSnapshot snap, int index) {
    return FederalPRStats(
      index: index,
      partyName: snap['partyName'],
      barColor: snap['barColor'],
      voteData: Vote.fromJson(snap['votes']),
    );
  }

}

class Vote {
  late int vote;
  late List<String> userId;

  Vote({
    required this.vote,
    required this.userId,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      vote: json['vote'],
      userId: ((json['userId'] ?? [])as List).map((e) => (e as String)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'like': this.vote,
    };
  }
}
