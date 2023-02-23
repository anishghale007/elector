import 'package:elector/constants/constants.dart';
import 'package:elector/widgets/form_container.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/sub_heading.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Text(
                'Reset Password',
                style: kHeadingTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Enter the email associated with your account and we will send an email to reset your password',
                style: kSubHeadingTextStyle,
              ),
            ),
            SizedBox(height: 100),
            SubHeading('Email address'),
            FormContainer(
              hint: 'Enter your Email address',
              keyboardType: TextInputType.emailAddress,
              controller: mailController,
              obscureText: false,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
            ),
            SizedBox(height: 180),
            PrimaryButton(
              text: 'Send Request',
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
