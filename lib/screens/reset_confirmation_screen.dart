import 'package:elector/constants/constants.dart';
import 'package:elector/screens/login_screen.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110, bottom: 70),
                child: Center(
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Image.asset(
                      'assets/images/reset_confirmation.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Check your Email Address',
                  style: kSubHeadingTextStyle.copyWith(fontSize: 21),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                child: Text(
                  'We have sent a mail to your email address to reset your password. \n'
                  'Note: If you cannot find it in your inbox, check it in the spam section',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFFB8B4B4),
                  ),
                ),
              ),
              SizedBox(height: 80),
              PrimaryButton(
                text: 'Back to Login',
                onPress: () {
                  Get.to(() => LoginScreen(), transition: Transition.zoom);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
