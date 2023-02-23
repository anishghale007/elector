import 'package:elector/constants/constants.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/screens/voteVerification_stepTwo.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/verification_container.dart';
import 'package:elector/widgets/verification_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class VoteVerificationStepOne extends StatelessWidget {
  String electionID;
  String electionType;
  String fptpID;
  String fptpURL;
  String fptpName;
  String prID;
  String prURL;
  String prName;
  String? province;

  VoteVerificationStepOne({
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

  final pinController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                VerificationSteps(
                  containerOne: kInactiveColor,
                  circleOne: kInactiveColor,
                  containerTwo: kInactiveColor,
                  circleTwo: kInactiveColor,
                ),
                SizedBox(height: 100),
                VerificationContainer(
                  hint: 'Enter your PIN',
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  obscureText: false,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.none,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'PIN is required';
                    }
                    if (val.length > 10) {
                      return 'Maximum PIN length is 10';
                    }
                    if (val.length < 4) {
                      return 'Minimum PIN length is 4';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 80),
                Text(
                  'Please enter your PIN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text(
                    'The PIN (Personal Identification Number) is the code or number that you entered during the registration process',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFB8B4B4),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Consumer(
                  builder: (context, ref, child) {
                    final user = ref.watch(userStream);
                    return user.when(
                      data: (data) {
                        return PrimaryButton(
                          text: 'Continue',
                          onPress: () async {
                            _form.currentState!.save();
                            if (_form.currentState!.validate()) {
                              if (data.pin == pinController.text.trim()) {
                                Get.to(
                                    () => VoteVerificationStepTwo(
                                          fptpID: fptpID,
                                          fptpURL: fptpURL,
                                          fptpName: fptpName,
                                          prURL: prURL,
                                          prName: prName,
                                          prID: prID,
                                          electionID: electionID,
                                          electionType: electionType,
                                          province: province,
                                        ),
                                    transition: Transition.native);
                              } else {
                                Get.dialog(CustomDialog(
                                  icon: Icons.error,
                                  title: 'Wrong PIN',
                                  description: 'Please enter the correct PIN',
                                  buttonText: 'Close',
                                ));
                              }
                            }
                          },
                        );
                      },
                      error: (err, stack) => Text('$err'),
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          color: kMainThemeColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
