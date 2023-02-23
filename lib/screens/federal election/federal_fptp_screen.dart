import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/screens/federal%20election/federal_pr_screen.dart';
import 'package:elector/widgets/election_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FederalFPTP extends StatelessWidget {
  String electionID;
  String electionType;

  FederalFPTP({
    required this.electionID,
    required this.electionType,
  });

  Future<int> countDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('federal fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Candidate Vote',
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
          final fptpStream = ref.watch(fptpProvider);
          return Column(
            children: [
              FutureBuilder<int>(
                future: countDocuments(),
                builder: (BuildContext context, snapshot) {
                  final count = snapshot.data;
                  return ElectionCard(
                    electionType: 'Federal Election',
                    candidateTotal: 'Candidates: ' + count.toString(),
                    votingType: 'First-past-the-post voting',
                    ballotNo: '1',
                  );
                },
              ),
              fptpStream.when(
                data: (data) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final dat = data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Flexible(
                            child: Card(
                              color: Color(0xFFF5F5F5),
                              shadowColor: Colors.black,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                          child: Image.network(dat.imageUrl,
                                              fit: BoxFit.cover),
                                        ),
                                        CircleAvatar(
                                          backgroundImage:
                                          NetworkImage(dat.partyUrl),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    dat.candidateName,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    dat.partyName,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 30),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 80),
                                            child: Container(
                                              height: 40,
                                              width: 135,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: kMainThemeColor,
                                                ),
                                                onPressed: () {
                                                  Get.to(
                                                      () => FederalPR(
                                                            fptpID: dat.id,
                                                            fptpName: dat
                                                                .candidateName,
                                                            fptpURL:
                                                                dat.imageUrl,
                                                            electionID:
                                                                electionID,
                                                        electionType: electionType,
                                                          ),
                                                      transition:
                                                          Transition.native);
                                                },
                                                child: Text(
                                                  'Vote',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
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
                        );
                      },
                    ),
                  );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: kMainThemeColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
