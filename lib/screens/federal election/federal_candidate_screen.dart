import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/screens/candidate_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FederalCandidateScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Federal Election Aspirants', style: TextStyle(color: Colors.black),),
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
          return SingleChildScrollView(
            child: Column(
              children: [
                fptpStream.when(
                  data: (data) {
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 90.h,
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
                                                    backgroundColor: kMainThemeColor,
                                                  ),
                                                  onPressed: () {
                                                    Get.to(() => CandidateDetailsScreen(
                                                      image: dat.imageUrl,
                                                      partyImage: dat.partyUrl,
                                                      partyName: dat.partyName,
                                                      candidateName: dat.candidateName,
                                                      candidateInfo: dat.candidateInfo,
                                                    ), transition: Transition.native);
                                                  },
                                                  child: Text(
                                                    'View Profile',
                                                    style:
                                                    TextStyle(fontSize: 10.sp),
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
                SizedBox(height: 40),
              ],
            ),
          );
        }
      ),
    );
  }
}
