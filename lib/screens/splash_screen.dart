import 'package:elector/constants/constants.dart';
import 'package:elector/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.to(() => LoginScreen(), transition: Transition.native);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return LoginScreen();
      // }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainThemeColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: 20),
            Container(
              height: 20,
              width: 20,
            ),
            Container(
              height: 300,
              width: 300,
              child: Image.asset('assets/images/elector_light.png'),
            ),
            Center(
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/images/election_commission.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
