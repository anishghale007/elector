import 'package:elector/api/local_auth_api.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/screens/voteVerification_stepThree.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/verification_steps.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class VoteVerificationStepTwo extends StatefulWidget {

  String electionID;
  String electionType;
  String fptpID;
  String fptpURL;
  String fptpName;
  String prID;
  String prURL;
  String prName;
  String? province;

  VoteVerificationStepTwo({
    required this.fptpID,
    required this.fptpURL,
    required this.fptpName,
    required this.prID,
    required this.prURL,
    required this.prName,
    required this.electionID,
    required this.electionType,
    this.province,
  });

  @override
  State<VoteVerificationStepTwo> createState() =>
      _VoteVerificationStepTwoState();
}

class _VoteVerificationStepTwoState extends State<VoteVerificationStepTwo> {



  Future<String> authenticate() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {}
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              VerificationSteps(
                containerOne: kMainThemeColor,
                circleOne: kMainThemeColor,
                containerTwo: kInactiveColor,
                circleTwo: kInactiveColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.24,
                margin: EdgeInsets.symmetric(vertical: 80),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: FaIcon(
                    FontAwesomeIcons.fingerprint,
                    color: kMainThemeColor,
                  ),
                ),
              ),
              Text(
                'Scan your fingerprint',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  'Tap on the button to verify your fingerprint',
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
                text: 'Verify Fingerprint',
                onPress: () async {
                  final response = await authenticate();
                  if (response == 'Success') {
                    Get.to(() => VoteVerificationStepThree(
                      fptpID: widget.fptpID,
                      fptpURL: widget.fptpURL,
                      fptpName: widget.fptpName,
                      prURL: widget.prURL,
                      prName: widget.prName,
                      prID: widget.prID,
                      electionID: widget.electionID,
                      electionType: widget.electionType,
                      province: widget.province,
                    ),
                        transition: Transition.native);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
