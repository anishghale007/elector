import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/ongoingElection_provider.dart';
import 'package:elector/controller/provincial%20controller/gandakiPR_stats_controller.dart';
import 'package:elector/controller/provincial%20controller/gandaki_provider.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/provincial controller/bagmatiPR_stats_controller.dart';

class GandakiPrStats extends StatefulWidget {
  GandakiPrStats({Key? key}) : super(key: key);

  @override
  State<GandakiPrStats> createState() => _GandakiPrStatsState();
}

class _GandakiPrStatsState extends State<GandakiPrStats> {
  String? totalUsers;
  String? totalVotes;
  String voteTurnOut = "";
  double? voterTurnout;

  Future<int> countUsersDocuments() async {
    QuerySnapshot myDoc =
    await FirebaseFirestore.instance.collection('users').get();
    List<DocumentSnapshot> myDocCount = myDoc.docs;
    totalUsers = myDocCount.length.toString();
    return myDocCount.length;
  }

  String count() {
    print(voterTurnout);
    voterTurnout = int.parse(totalVotes!) / int.parse(totalUsers!) * 100;
    voteTurnOut = voterTurnout!.toStringAsFixed(2);
    return voteTurnOut;
  }

  final GandakiPRStatsController gandakiPRStatsController =
  Get.put(GandakiPRStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final sortedStream = ref.watch(gandakiPrSortedProvider);
        final totalVoteStream = ref.watch(ongoingProvincialTotalVotesProvider);
        return ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 40),
            FutureBuilder(
              future: gandakiPRStatsController.stats.value,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProvincialPRStats>> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Expanded(
                      child: Container(
                        height: 300,
                        width: 1000,
                        padding: EdgeInsets.all(10),
                        child: CustomBarChart(
                          gandakiPRStats: snapshot.data!,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 40),
            FutureBuilder(
              future: gandakiPRStatsController.stats.value,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ProvincialPRStats>> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Expanded(
                      child: Container(
                        height: 300,
                        width: 600,
                        padding: EdgeInsets.all(10),
                        child: CustomPieChart(
                          gandakiPRStats: snapshot.data!,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.purple[800],
                      ),
                      child: totalVoteStream.when(
                        data: (data) {
                          totalVotes = data.totalVote.toString();
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total Vote Counts',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                data.totalVote.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                        error: (err, stack) => Text('$err'),
                        loading: () => Center(
                          child: CircularProgressIndicator(
                            color: kMainThemeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[800],
                      ),
                      child: FutureBuilder<int>(
                        future: countUsersDocuments(),
                        builder: (BuildContext context, snapshot) {
                          final count = snapshot.data;
                          if (snapshot.hasData) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Users',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    count.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final vote = await count();
                        setState(() {
                          voteTurnOut = vote;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green[800],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Voter Turnout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                voteTurnOut + ' %',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Parties Vote Count (Rank Wise)',
                  style: kSubHeadingTextStyle.copyWith(fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(height: 40),
            sortedStream.when(
              data: (data) {
                return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final dat = data[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Card(
                          color: Color(0xFFF5F5F5),
                          shadowColor: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 30),
                                        CircleAvatar(
                                          backgroundImage:
                                          NetworkImage(dat.imageUrl),
                                          radius: 30,
                                        ),
                                        SizedBox(width: 30),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 30),
                                            Text(
                                              dat.partyName,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 30),
                                            Container(
                                              height: 40,
                                              width: 135,
                                              decoration: BoxDecoration(
                                                color: kMainThemeColor,
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    dat.voteData.vote
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
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
        );
      }),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({
    Key? key,
    required this.gandakiPRStats,
  }) : super(key: key);

  final List<ProvincialPRStats> gandakiPRStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ProvincialPRStats, String>> series = [
      charts.Series(
        id: 'Gandaki PR',
        data: gandakiPRStats,
        domainFn: (series, _) => series.partyName.toString(),
        measureFn: (series, _) => series.voteData.vote,
        colorFn: (series, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(series.barColor))),
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 3),
      behaviors: [
        new charts.DatumLegend(
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black, fontSize: 12),
        ),
      ],
    );
  }
}

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    Key? key,
    required this.gandakiPRStats,
  }) : super(key: key);

  final List<ProvincialPRStats> gandakiPRStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ProvincialPRStats, String>> series = [
      charts.Series(
        id: 'Gandaki PR',
        data: gandakiPRStats,
        domainFn: (series, _) => series.partyName.toString(),
        measureFn: (series, _) => series.voteData.vote,
        colorFn: (series, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(series.barColor))),
      )
    ];
    return charts.PieChart<String>(
      series,
      animate: true,
      animationDuration: Duration(seconds: 3),
      behaviors: [
        new charts.DatumLegend(
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black, fontSize: 12),
        ),
      ],
    );
  }
}
