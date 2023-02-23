import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class ElectionCard extends StatelessWidget {
  String electionType;
  String candidateTotal;
  String votingType;
  String ballotNo;

  ElectionCard({
    required this.electionType,
    required this.candidateTotal,
    required this.votingType,
    required this.ballotNo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Flexible(
        child: Card(
          color: kMainThemeColor,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    electionType,
                    style: kHeadingTextStyle.copyWith(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    candidateTotal,
                    style: kSubHeadingTextStyle.copyWith(
                        color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 13),
                  Text(
                    votingType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Color(0xFFDADADA),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Ballot Paper-' + ballotNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Color(0xFFDADADA),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
