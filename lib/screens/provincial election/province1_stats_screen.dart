import 'package:elector/constants/constants.dart';
import 'package:elector/screens/provincial%20election/province1_fptp_stats.dart';
import 'package:elector/screens/provincial%20election/province1_pr_stats.dart';
import 'package:flutter/material.dart';

class Province1StatsScreen extends StatefulWidget {
  @override
  State<Province1StatsScreen> createState() => _Province1StatsScreenState();
}

class _Province1StatsScreenState extends State<Province1StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainThemeColor,
          title: Text('Province 1 Vote Stats'),
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
            Province1FptpStats(),
            Province1PrStats(),
          ],
        ),
      ),
    );
  }
}
