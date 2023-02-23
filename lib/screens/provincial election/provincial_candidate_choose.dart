import 'package:elector/constants/constants.dart';
import 'package:elector/screens/provincial%20election/provincial_candidate_screen.dart';
import 'package:elector/widgets/provincial_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvincialCandidateChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Provincial Election Aspirants',
          style: TextStyle(color: Colors.black),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please select a province',
                style: kSubHeadingTextStyle,
              ),
              SizedBox(height: 30),
              ProvincialCard(
                image: 'assets/images/Province_1.png',
                provinceName: 'Province 1',
                onPress: () {
                  Get.to(
                      () => ProvincialCandidateScreen(province: 'Province 1'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Madhesh_Province.png',
                provinceName: 'Madhesh Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Madhesh'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Bagmati_Pradesh.png',
                provinceName: 'Bagmati Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Bagmati'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Gandaki_Pradesh.png',
                provinceName: 'Gandaki Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Gandaki'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Lumbini_Pradesh.png',
                provinceName: 'Lumbini Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Lumbini'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Karnali_Pradesh.png',
                provinceName: 'Karnali Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Karnali'));
                },
              ),
              ProvincialCard(
                image: 'assets/images/Sudurpashchim_Pradesh.png',
                provinceName: 'Sudurpashchim Province',
                onPress: () {
                  Get.to(() => ProvincialCandidateScreen(province: 'Sudurpashchim'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
