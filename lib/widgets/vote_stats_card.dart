import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class VoteStatsCard extends StatelessWidget {

  String title;
  dynamic onPress;

  VoteStatsCard({required this.title, required this.onPress,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              color: kMainThemeColor,
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: kSubHeadingTextStyle,
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
