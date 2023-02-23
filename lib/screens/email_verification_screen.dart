import 'dart:async';
import 'package:elector/constants/constants.dart';
import 'package:elector/screens/fingerprint_screen.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/secondary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {

  final String password;

  EmailVerificationPage({required this.password});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  final user = FirebaseAuth.instance.currentUser!.email;


  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(
        Duration(seconds: 8),
      );
      setState(() => canResendEmail = true);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    // User needs to created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? FingerprintScreen(email: user!, password: widget.password,)
      : Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 110, bottom: 70),
                    child: Container(
                      height: 240,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child:
                            Image.asset('assets/images/email_verification.png'),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Verify your Email Address',
                      style: kSubHeadingTextStyle.copyWith(fontSize: 21),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 32),
                    child: Text(
                      'A verification email has been sent to your email. Click the link to activate your account \n'
                      'Note: If you cannot find it in your inbox, check it in the spam section',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFB8B4B4),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  PrimaryButton(
                    text: 'Resend Email',
                    onPress: () {},
                  ),
                  kDefaultSizedBox,
                  SecondaryButton(
                    text: 'Cancel',
                    onPress: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
}
