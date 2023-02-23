import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class VerificationSteps extends StatelessWidget {
  final Color containerOne;
  final Color containerTwo;
  final Color circleOne;
  final Color circleTwo;

  VerificationSteps({
    required this.containerOne,
    required this.circleOne,
    required this.containerTwo,
    required this.circleTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                backgroundColor: kMainThemeColor,
                radius: 15,
              ),
              SizedBox(height: 10),
              Text(
                'Verify \n PIN',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 6,
            width: 70,
            color: containerOne,
          ),
          Column(
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                backgroundColor: circleOne,
                radius: 15,
              ),
              SizedBox(height: 10),
              Text(
                'Biometric \n Verification',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Container(
            height: 6,
            width: 70,
            color: containerTwo,
          ),
          Column(
            children: [
              SizedBox(height: 50),
              CircleAvatar(
                backgroundColor: circleTwo,
                radius: 15,
              ),
              SizedBox(height: 10),
              Text(
                'Confirm \n Vote',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
