import 'package:elector/constants/constants.dart';
import 'package:elector/screens/federal%20election/federal_fptp_stats.dart';
import 'package:elector/screens/federal%20election/federal_pr_stats.dart';
import 'package:flutter/material.dart';

class FederalStatsScreen extends StatefulWidget {

  @override
  State<FederalStatsScreen> createState() => _FederalStatsScreenState();
}

class _FederalStatsScreenState extends State<FederalStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainThemeColor,
            title: Text('Federal Election Vote Stats'),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: TabBar(
                onTap: (index) {
                  print(index);
                },
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 7, color: Colors.white),
                ),
                tabs: [
                  Tab(
                    text: 'FPTP',
                  ),
                  Tab(
                    text: 'PR',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              FederalFptpStats(),
              FederalPrStats(),
            ],
          ),
        ),
    );
  }
}
