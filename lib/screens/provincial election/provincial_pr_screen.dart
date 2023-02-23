import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/provincial%20controller/bagmati_provider.dart';
import 'package:elector/controller/provincial%20controller/gandaki_provider.dart';
import 'package:elector/controller/provincial%20controller/karnali_provider.dart';
import 'package:elector/controller/provincial%20controller/lumbini_provider.dart';
import 'package:elector/controller/provincial%20controller/madhesh_provider.dart';
import 'package:elector/controller/provincial%20controller/province1_provider.dart';
import 'package:elector/controller/provincial%20controller/sudurpaschim_provider.dart';
import 'package:elector/screens/voteVerification_stepOne.dart';
import 'package:elector/widgets/election_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class ProvincialPRScreen extends StatelessWidget {
  String electionID;
  String electionType;
  String fptpID;
  String fptpURL;
  String fptpName;
  String province;

  ProvincialPRScreen({
    required this.fptpID,
    required this.fptpURL,
    required this.fptpName,
    required this.electionID,
    required this.electionType,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          province + ' Parties Vote',
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
          final province1Stream = ref.watch(province1PRProvider);
          final bagmatiStream = ref.watch(bagmatiPRProvider);
          final gandakiStream = ref.watch(gandakiPRProvider);
          final karnaliStream = ref.watch(karnaliPRProvider);
          final lumbiniStream = ref.watch(lumbiniPRProvider);
          final madheshStream = ref.watch(madheshPRProvider);
          final sudurpaschimStream = ref.watch(sudurpaschimPRProvider);
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              if (province == "Province 1")
                FutureBuilder<int>(
                  future: countProvince1Documents(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 30,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                              () => VoteVerificationStepOne(
                                                    province: province,
                                                    fptpID: fptpID,
                                                    fptpName: fptpName,
                                                    fptpURL: fptpURL,
                                                    prID: dat.id,
                                                    prName: dat.partyName,
                                                    prURL: dat.imageUrl,
                                                    electionID: electionID,
                                                    electionType: electionType,
                                                  ),
                                              transition: Transition.native);
                                        },
                                        child: Text('Vote'),
                                        style: ElevatedButton.styleFrom(
                                          primary: kMainThemeColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
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
              if (province == "Madhesh")
                FutureBuilder<int>(
                  future: countMadheshDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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
              if (province == "Bagmati")
                FutureBuilder<int>(
                  future: countBagmatiDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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
              if (province == "Gandaki")
                FutureBuilder<int>(
                  future: countGandakiDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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
              if (province == "Lumbini")
                FutureBuilder<int>(
                  future: countLumbiniDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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
              if (province == "Karnali")
                FutureBuilder<int>(
                  future: countKarnaliDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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
              if (province == "Sudurpashchim")
                FutureBuilder<int>(
                  future: countSudurpaschimDocuments(),
                  builder: (BuildContext context, snapshot) {
                    final count = snapshot.data;
                    return ElectionCard(
                      electionType: 'Provincial Election',
                      candidateTotal: 'Parties: ' + count.toString(),
                      votingType: 'Proportional voting',
                      ballotNo: '2',
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
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                margin:
                                EdgeInsets.symmetric(horizontal: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.to(
                                            () => VoteVerificationStepOne(
                                          province: province,
                                          fptpID: fptpID,
                                          fptpName: fptpName,
                                          fptpURL: fptpURL,
                                          prID: dat.id,
                                          prName: dat.partyName,
                                          prURL: dat.imageUrl,
                                          electionID: electionID,
                                          electionType: electionType,
                                        ),
                                        transition: Transition.native);
                                  },
                                  child: Text('Vote'),
                                  style: ElevatedButton.styleFrom(
                                    primary: kMainThemeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(15),
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

  Future<int> countProvince1Documents() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('province 1 pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countGandakiDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('gandaki pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countBagmatiDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('bagmati pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countLumbiniDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('lumbini pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countSudurpaschimDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('sudurpaschim pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countMadheshDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('madhesh pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }

  Future<int> countKarnaliDocuments() async {
    QuerySnapshot myDoc =
        await FirebaseFirestore.instance.collection('karnali pr').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    return myDocCount.length;
  }
}
