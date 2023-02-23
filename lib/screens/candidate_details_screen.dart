import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CandidateDetailsScreen extends StatelessWidget {
  final String image;
  final String partyImage;
  final String partyName;
  final String candidateName;
  final String candidateInfo;

  CandidateDetailsScreen({
    required this.image,
    required this.partyImage,
    required this.partyName,
    required this.candidateName,
    required this.candidateInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Candidate Details Screen',
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
                  child: Image.network(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidateName,
                        style: kSubHeadingTextStyle,
                      ),
                      SizedBox(height: 10),
                      Text(
                        partyName,
                        style: kSubHeadingTextStyle.copyWith(
                            color: Colors.black54, fontSize: 10.sp),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(partyImage),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Text(
                candidateInfo,
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
