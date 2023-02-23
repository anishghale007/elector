import 'package:elector/constants/constants.dart';
import 'package:elector/controller/upcomingElection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpcomingElectionPage extends StatefulWidget {
  @override
  State<UpcomingElectionPage> createState() => _UpcomingElectionPageState();
}

class _UpcomingElectionPageState extends State<UpcomingElectionPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final upcomingElectionStream = ref.watch(upcomingElectionProvider);
          return Column(
            children: [
              upcomingElectionStream.when(
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
                                          Flexible(
                                            child: Container(
                                              width: 90,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: kMainThemeColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    dat.day,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    dat.month,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  dat.electionType,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          WidgetSpan(
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_month,
                                                              size: 18,
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
