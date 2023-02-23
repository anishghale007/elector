import 'package:elector/constants/constants.dart';
import 'package:elector/controller/ongoingElection_provider.dart';
import 'package:elector/screens/instruction_screen.dart';
import 'package:elector/screens/provincial%20election/provincial_vote_screen.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OngoingElectionPage extends StatelessWidget {
  final user = auth.FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final ongoingElectionStream = ref.watch(ongoingElectionProvider);
          return Column(
            children: [
              ongoingElectionStream.when(
                data: (data) {
                  return data.isEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 100),
                            Container(
                              height: 300,
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Image.asset(
                                'assets/images/No data.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                'No Ongoing Election at the moment',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 30),
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final dat = data[index];
                              return dat.canVote == false
                                  ? Column(
                                      children: [
                                        SizedBox(height: 100),
                                        Container(
                                          height: 30.h,
                                          width: 50.w,
                                          child: Image.asset(
                                            'assets/images/No data.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: Text(
                                            'No Ongoing Election at the moment',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        if (dat.voterId.contains(user.uid)) {
                                          Get.dialog(
                                            CustomDialog(
                                                icon: Icons.warning,
                                                title: 'You have already voted !!',
                                                description: 'Only one vote per one person is allowed.',
                                                buttonText: 'Ok',
                                            )
                                          );
                                          print(user.uid);
                                        } else {
                                          if (dat.electionType ==
                                              'Federal Election') {
                                            Get.to(() => InstructionScreen(
                                                electionId: dat.id, electionType: dat.electionType,));
                                          }
                                          if (dat.electionType ==
                                              'Provincial Election') {
                                            Get.to(() => ProvincialVoteScreen(
                                                  electionId: dat.id,
                                              electionType: dat.electionType,
                                                ));
                                          }
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        child: Flexible(
                                          child: Card(
                                            color: Color(0xFFF5F5F5),
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      left: BorderSide(
                                                    color: kMainThemeColor,
                                                    width: 15,
                                                  )),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        dat.electionType,
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        'Candidates: ' +
                                                            dat.candidates,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF706E6E),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      Container(
                                                        width: double.infinity,
                                                        color:
                                                            Color(0xFFD9D9D9),
                                                        height: 2,
                                                      ),
                                                      SizedBox(height: 15),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'Start Date: ',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons
                                                                    .hourglass_top,
                                                                size: 18,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '  ' +
                                                                  dat.startDate +
                                                                  ' at ' +
                                                                  dat.startTime,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'End Date:   ',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons
                                                                    .hourglass_bottom,
                                                                size: 18,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text: '  ' +
                                                                  dat.startDate +
                                                                  ' at ' +
                                                                  dat.startTime,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF706E6E),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: kMainThemeColor,
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
