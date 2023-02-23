import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/screens/voteVerification_stepOne.dart';
import 'package:elector/widgets/election_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class FederalPR extends StatelessWidget {
  String electionID;
  String electionType;
  String fptpID;
  String fptpURL;
  String fptpName;

  FederalPR({
    required this.fptpID,
    required this.fptpURL,
    required this.fptpName,
    required this.electionID,
    required this.electionType,
  });

  Future<int> countDocuments() async {
    QuerySnapshot myDoc =
    await FirebaseFirestore.instance.collection('federal pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Party Vote',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
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
      body: Consumer(
        builder: (context, ref, child) {
          final prStream = ref.watch(prProvider);
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              FutureBuilder<int>(
                future: countDocuments(),
                builder: (BuildContext context, snapshot) {
                  final count = snapshot.data;
                  return ElectionCard(
                    electionType: 'Federal Election',
                    candidateTotal: 'Parties: ' + count.toString(),
                    votingType: 'Proportional voting',
                    ballotNo: '2',
                  );
                },
              ),
              prStream.when(
                data: (data) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 2 / 2.5,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 25),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final dat = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38,
                                blurRadius: 10,
                                offset: Offset(0, 6),
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Image.network(dat.imageUrl,
                                      fit: BoxFit.contain),
                                ),
                              ),
                              Text(
                                dat.partyName,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => VoteVerificationStepOne(
                                      fptpID: fptpID,
                                      fptpName: fptpName,
                                      fptpURL: fptpURL,
                                      prID: dat.id,
                                      prName: dat.partyName,
                                      prURL: dat.imageUrl,
                                      electionID: electionID,
                                      electionType: electionType,
                                    ), transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: kMainThemeColor,
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
