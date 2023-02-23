import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class VotingHistoryScreen extends StatefulWidget {
  String docId;

  VotingHistoryScreen({required this.docId});

  @override
  State<VotingHistoryScreen> createState() => _VotingHistoryScreenState();
}

class _VotingHistoryScreenState extends State<VotingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Voting History',
                style: TextStyle(
                  color: kMainThemeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Showing history of your votes',
                style: TextStyle(color: Colors.grey[700], fontSize: 11.sp),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 8.h,
              color: Colors.grey[200],
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()) +
                          ' (Today)',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.docId)
                  .collection('voting history')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 90.h,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          DocumentSnapshot snapData =
                              snapshot.data!.docs[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: index == 0
                                  ? Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    )
                                  : Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                            ),
                            child: ListTile(
                              leading: Icon(
                                Icons.how_to_vote,
                                color: kMainThemeColor,
                              ),
                              title: Text(
                                snapData['electionType'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Text(
                                snapData['votedDate'].toString(),
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Center(
                          child: Container(
                            height: 40.h,
                            width: 60.w,
                            child: Image.asset('assets/images/No data.png'),
                          ),
                        ),
                      ),
                      Text(
                        'No Data Found',
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
