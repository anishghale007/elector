import 'package:elector/constants/constants.dart';
import 'package:elector/screens/provincial%20election/bagmati_stats_screen.dart';
import 'package:elector/screens/provincial%20election/gandaki_stats_screen.dart';
import 'package:elector/screens/provincial%20election/karnali_stats_screen.dart';
import 'package:elector/screens/provincial%20election/lumbini_stats_screen.dart';
import 'package:elector/screens/provincial%20election/madhesh_stats_screen.dart';
import 'package:elector/screens/provincial%20election/province1_stats_screen.dart';
import 'package:elector/screens/provincial%20election/sudurpaschim_stats_screen.dart';
import 'package:elector/widgets/provincial_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvincialStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provincial Election Vote Stats'),
        backgroundColor: kMainThemeColor,
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
                  Get.to(() => Province1StatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Madhesh_Province.png',
                provinceName: 'Madhesh Province',
                onPress: () {
                  Get.to(() => MadheshStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Bagmati_Pradesh.png',
                provinceName: 'Bagmati Province',
                onPress: () {
                  Get.to(() => BagmatiStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Gandaki_Pradesh.png',
                provinceName: 'Gandaki Province',
                onPress: () {
                  Get.to(() => GandakiStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Lumbini_Pradesh.png',
                provinceName: 'Lumbini Province',
                onPress: () {
                  Get.to(() => LumbiniStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Karnali_Pradesh.png',
                provinceName: 'Karnali Province',
                onPress: () {
                  Get.to(() => KarnaliStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
              ProvincialCard(
                image: 'assets/images/Sudurpashchim_Pradesh.png',
                provinceName: 'Sudurpashchim Province',
                onPress: () {
                  Get.to(() => SudurpaschimStatsScreen(), transition: Transition.rightToLeft);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
