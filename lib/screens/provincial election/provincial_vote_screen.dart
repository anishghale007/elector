import 'package:elector/constants/constants.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/screens/instruction_screen.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:elector/widgets/provincial_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ProvincialVoteScreen extends StatelessWidget {
  String electionId;
  String electionType;

  ProvincialVoteScreen({
    required this.electionId,
    required this.electionType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Provincial Election',
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
        child: Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(userStream);
            return user.when(
              data: (data) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please select your province',
                        style: kSubHeadingTextStyle,
                      ),
                      SizedBox(height: 30),
                      ProvincialCard(
                        image: 'assets/images/Province_1.png',
                        provinceName: 'Province 1',
                        onPress: () {
                          if (data.province == "Province No.1") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Province 1",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Madhesh_Province.png',
                        provinceName: 'Madhesh Province',
                        onPress: () {
                          if (data.province == "Madhesh") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Madhesh",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Bagmati_Pradesh.png',
                        provinceName: 'Bagmati Province',
                        onPress: () {
                          if (data.province == "Bagmati") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Bagmati",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Gandaki_Pradesh.png',
                        provinceName: 'Gandaki Province',
                        onPress: () {
                          if (data.province == "Gandaki") {
                            Get.to(
                                () => InstructionScreen(
                                      electionId: electionId,
                                      electionType: electionType,
                                      province: "Gandaki",
                                    ),
                                transition: Transition.rightToLeft);
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Lumbini_Pradesh.png',
                        provinceName: 'Lumbini Province',
                        onPress: () {
                          if (data.province == "Lumbini") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Lumbini",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Karnali_Pradesh.png',
                        provinceName: 'Karnali Province',
                        onPress: () {
                          if (data.province == "Karnali") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Karnali",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                      ProvincialCard(
                        image: 'assets/images/Sudurpashchim_Pradesh.png',
                        provinceName: 'Sudurpashchim Province',
                        onPress: () {
                          if (data.province == "Sudurpaschim") {
                            Get.to(() => InstructionScreen(
                                  electionId: electionId,
                                  electionType: electionType,
                                  province: "Sudurpashchim",
                                ));
                          } else {
                            Get.dialog(CustomDialog(
                              icon: Icons.error_outline,
                              title: 'Wrong province',
                              description:
                                  'Please select the province you are originally from or the province you have chosen in the '
                                  'registration process',
                              buttonText: 'Close',
                            ));
                          }
                        },
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
