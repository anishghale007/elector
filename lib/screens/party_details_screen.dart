import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PartyDetailsScreen extends StatelessWidget {
  final String image;
  final String partyFullName;
  final String partyShortName;
  final String partyInfo;

  PartyDetailsScreen({
    required this.image,
    required this.partyFullName,
    required this.partyShortName,
    required this.partyInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Party Details Screen',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Container(
                  height: 25.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(image, fit: BoxFit.contain,),
                ),
              ),
              Text(
                partyFullName,
                style: kSubHeadingTextStyle,
              ),
              SizedBox(height: 10),
              Text(
                partyShortName,
                style: kSubHeadingTextStyle.copyWith(color: Colors.black54),
              ),
              SizedBox(height: 35),
              Text(
                partyInfo,
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
              ),
              SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }
}
