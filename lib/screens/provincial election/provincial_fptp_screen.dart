import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/provincial%20controller/bagmati_provider.dart';
import 'package:elector/controller/provincial%20controller/gandaki_provider.dart';
import 'package:elector/controller/provincial%20controller/karnali_provider.dart';
import 'package:elector/controller/provincial%20controller/lumbini_provider.dart';
import 'package:elector/controller/provincial%20controller/madhesh_provider.dart';
import 'package:elector/controller/provincial%20controller/province1_provider.dart';
import 'package:elector/controller/provincial%20controller/sudurpaschim_provider.dart';
import 'package:elector/screens/provincial%20election/provincial_pr_screen.dart';
import 'package:elector/widgets/election_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProvincialFPTPScreen extends StatelessWidget {
  String electionID;
  String electionType;
  String province;

  ProvincialFPTPScreen({
    required this.electionID,
    required this.electionType,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          province + ' Candidate Vote',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
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
          final province1Stream = ref.watch(province1FPTPProvider);
          final bagmatiStream = ref.watch(bagmatiFPTPProvider);
          final gandakiStream = ref.watch(gandakiFPTPProvider);
          final karnaliStream = ref.watch(karnaliFPTPProvider);
          final lumbiniStream = ref.watch(lumbiniFPTPProvider);
          final madheshStream = ref.watch(madheshFPTPProvider);
          final sudurpaschimStream = ref.watch(sudurpaschimFPTPProvider);
          return SingleChildScrollView(
            child: Column(
              children: [
                if (province == "Province 1")
                  FutureBuilder<int>(
                    future: countProvince1Documents(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Province 1")
                province1Stream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Madhesh")
                  FutureBuilder<int>(
                    future: countMadheshDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Madhesh")
                madheshStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Bagmati")
                  FutureBuilder<int>(
                    future: countBagmatiDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Bagmati")
                bagmatiStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Gandaki")
                  FutureBuilder<int>(
                    future: countGandakiDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Gandaki")
                gandakiStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Lumbini")
                  FutureBuilder<int>(
                    future: countLumbiniDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Lumbini")
                lumbiniStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Karnali")
                  FutureBuilder<int>(
                    future: countKarnaliDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Karnali")
                karnaliStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                if (province == "Sudurpashchim")
                  FutureBuilder<int>(
                    future: countSudurpaschimDocuments(),
                    builder: (BuildContext context, snapshot) {
                      final count = snapshot.data;
                      return ElectionCard(
                        electionType: 'Provincial Election',
                        candidateTotal: 'Candidates: ' + count.toString(),
                        votingType: 'First-past-the-post voting',
                        ballotNo: '1',
                      );
                    },
                  ),
                if (province == "Sudurpashchim")
                sudurpaschimStream.when(
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  child: Image.network(
                                                      dat.imageUrl,
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
                                                            CrossAxisAlignment
                                                                .start,
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Container(
                                                      height: 40,
                                                      width: 135,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kMainThemeColor,
                                                        ),
                                                        onPressed: () {
                                                          Get.to(
                                                              () =>
                                                                  ProvincialPRScreen(
                                                                    province:
                                                                        province,
                                                                    fptpID:
                                                                        dat.id,
                                                                    fptpName: dat
                                                                        .candidateName,
                                                                    fptpURL: dat
                                                                        .imageUrl,
                                                                    electionID:
                                                                        electionID,
                                                                    electionType:
                                                                        electionType,
                                                                  ),
                                                              transition:
                                                                  Transition
                                                                      .native);
                                                        },
                                                        child: Text(
                                                          'Vote',
                                                          style: TextStyle(
                                                              fontSize: 18),
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
            ),
          );
        },
      ),
    );
  }

  Future<int> countProvince1Documents() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('province 1 fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countGandakiDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('gandaki fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countBagmatiDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('bagmati fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countLumbiniDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('lumbini fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countSudurpaschimDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('sudurpaschim fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countMadheshDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('madhesh fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countKarnaliDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('karnali fptp').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }
}
