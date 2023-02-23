import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final dynamic onPress;

  SecondaryButton({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: kMainThemeColor, width: 2),
          ),
        ),
        onPressed: onPress,
        child: Text(text, style: kSubHeadingTextStyle.copyWith(color: kMainThemeColor),),
      ),
    );
  }
}
