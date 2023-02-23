import 'package:elector/constants/constants.dart';
import 'package:elector/screens/provincial%20election/gandaki_fptp_stats.dart';
import 'package:elector/screens/provincial%20election/gandaki_pr_stats.dart';
import 'package:flutter/material.dart';

class GandakiStatsScreen extends StatefulWidget {
  @override
  State<GandakiStatsScreen> createState() => _GandakiStatsScreenState();
}

class _GandakiStatsScreenState extends State<GandakiStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainThemeColor,
          title: Text('Gandaki Vote Stats'),
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
            GandakiFptpStats(),
            GandakiPrStats(),
          ],
        ),
      ),
    );
  }
}
