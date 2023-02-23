import 'package:elector/constants/constants.dart';
import 'package:elector/screens/provincial%20election/madhesh_fptp_stats.dart';
import 'package:elector/screens/provincial%20election/madhesh_pr_stats.dart';
import 'package:flutter/material.dart';

class MadheshStatsScreen extends StatefulWidget {
  @override
  State<MadheshStatsScreen> createState() => _MadheshStatsScreenState();
}

class _MadheshStatsScreenState extends State<MadheshStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainThemeColor,
          title: Text('Madhesh Vote Stats'),
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
            MadheshFptpStats(),
            MadheshPrStats(),
          ],
        ),
      ),
    );
  }
}
