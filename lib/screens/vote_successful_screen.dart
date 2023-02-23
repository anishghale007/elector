import 'package:elector/constants/constants.dart';
import 'package:elector/screens/home_screen.dart';
import 'package:elector/screens/main_screen.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VoteSuccessfulPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Future<bool> _onWillPop() async {
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140),
                    child: Container(
                      height: 250,
                      width: 300,
                      child: FittedBox(
                        child: Lottie.network(
                            'https://assets3.lottiefiles.com/packages/lf20_ejczmtks.json'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Successful',
                  style: kHeadingTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Text(
                    'You have successfully registered your vote',
                    textAlign: TextAlign.center,
                    style: kHintTextStyle.copyWith(
                      color: Color(0xFFB8B4B4),
                    ),
                  ),
                ),
                SizedBox(height: 120),
                PrimaryButton(text: 'Back to Home', onPress: () {
                  Get.to(() => MainScreen(), transition: Transition.native);
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
