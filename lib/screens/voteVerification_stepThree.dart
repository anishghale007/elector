import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/controller/ongoingElection_provider.dart';
import 'package:elector/controller/provincial%20controller/bagmati_provider.dart';
import 'package:elector/controller/provincial%20controller/gandaki_provider.dart';
import 'package:elector/controller/provincial%20controller/karnali_provider.dart';
import 'package:elector/controller/provincial%20controller/lumbini_provider.dart';
import 'package:elector/controller/provincial%20controller/madhesh_provider.dart';
import 'package:elector/controller/provincial%20controller/province1_provider.dart';
import 'package:elector/controller/provincial%20controller/sudurpaschim_provider.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/models/federal_election.dart';
import 'package:elector/screens/main_screen.dart';
import 'package:elector/screens/vote_successful_screen.dart';
import 'package:elector/widgets/verification_steps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

class VoteVerificationStepThree extends StatelessWidget {
  String electionID;
  String electionType;
  String fptpID;
  String fptpURL;
  String fptpName;
  String prID;
  String prURL;
  String prName;
  String? province;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  String? docId;

  VoteVerificationStepThree({
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

  final user = auth.FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VerificationSteps(
                    containerOne: kMainThemeColor,
                    circleOne: kMainThemeColor,
                    containerTwo: kMainThemeColor,
                    circleTwo: kMainThemeColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.38,
                          color: Colors.green,
                          child: Image.network(
                            fptpURL,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ballot Paper-1',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              fptpName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.38,
                          color: Colors.green,
                          child: Image.network(
                            prURL,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ballot Paper-2',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              prName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Flexible(
                      child: Card(
                        color: Color(0xFFF8EEEC),
                        shadowColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.black, width: 1),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 18),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'WARNING!',
                                  style: kSubHeadingTextStyle.copyWith(
                                      color: kMainThemeColor),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Are you sure you want to vote for this candidate?'
                                  ' Once confirmed this action cannot be reversed.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 25),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kMainThemeColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          onPressed: () async {
                                            if(province == "Province 1") {
                                              await ref.read(province1Provider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(province1Provider).addPRVote(prID, user.uid);
                                            } else if(province == "Bagmati") {
                                              await ref.read(bagmatiProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(bagmatiProvider).addPRVote(prID, user.uid);
                                            } else if(province == "Madhesh") {
                                              await ref.read(madheshProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(madheshProvider).addPRVote(prID, user.uid);
                                            } else if(province == "Gandaki") {
                                              await ref.read(gandakiProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(gandakiProvider).addPRVote(prID, user.uid);
                                            } else if(province == "Lumbini") {
                                              await ref.read(lumbiniProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(lumbiniProvider).addPRVote(prID, user.uid);
                                            } else if(province == "Karnali") {
                                              await ref.read(karnaliProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(karnaliProvider).addPRVote(prID, user.uid);
                                            } else if(province == "Sudurpashchim") {
                                              await ref.read(sudurpaschimProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(sudurpaschimProvider).addPRVote(prID, user.uid);
                                            } else {
                                              await ref.read(federalProvider).addFPTPVote(fptpID, user.uid);
                                              await ref.read(federalProvider).addPRVote(user.uid, prID);
                                            }
                                            await ref.read(ongoingProvider).addUserID(electionID, user.uid);
                                            await ref
                                                .read(userProvider)
                                                .addVotingHistory(
                                                    postId: docId!,
                                                    electionType:
                                                        electionType);
                                            Get.to(() => VoteSuccessfulPage(), transition: Transition.native);
                                          },
                                          child: Text(
                                            'Confirm',
                                            style: kSubHeadingTextStyle
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              side: BorderSide(
                                                  color: kMainThemeColor,
                                                  width: 1),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.to(() => MainScreen(),
                                                transition: Transition.native);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style:
                                                kSubHeadingTextStyle.copyWith(
                                                    color: kMainThemeColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('userId', isEqualTo: uid)
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        docId = snapshot.data.docs[0].reference.id.toString();
                        return Text(
                          snapshot.data.docs[0].reference.id.toString(),
                          style: TextStyle(color: Colors.transparent),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
