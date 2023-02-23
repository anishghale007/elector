import 'package:elector/constants/constants.dart';
import 'package:elector/controller/ongoingElection_provider.dart';
import 'package:elector/screens/federal%20election/federal_stats_screen.dart';
import 'package:elector/screens/provincial%20election/provincial_stats_screen.dart';
import 'package:elector/widgets/vote_stats_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class VoteStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (context, ref, child) {
        final ongoingElection = ref.watch(ongoingTotalVotesProvider);
        return SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vote Stats',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kMainThemeColor),
                      ),
                      Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFDD0C39),
                              Colors.redAccent,
                            ],
                            begin: const FractionalOffset(0.0, 1.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: ongoingElection.when(
                          data: (data) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (data.canVote == true)
                                  Text(
                                    'Ongoing Voting',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                if (data.canVote == false)
                                  Text(
                                    'Voting Ended',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                              ],
                            );
                          },
                          error: (err, stack) => Text('$err'),
                          loading: () => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 50,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'SELECT ELECTION',
                      style: kSubHeadingTextStyle.copyWith(
                          color: Colors.redAccent),
                    ),
                  ),
                ),
                VoteStatsCard(
                  title: 'Federal Election',
                  onPress: () {
                    Get.to(() => FederalStatsScreen(),
                        transition: Transition.rightToLeft);
                  },
                ),
                VoteStatsCard(
                  title: 'Provincial Election',
                  onPress: () {
                    Get.to(() => ProvincialStatsScreen(),
                        transition: Transition.rightToLeft);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
