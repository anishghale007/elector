import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String text;

  SubHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(text, style: kSubHeadingTextStyle),
    );
  }
}
