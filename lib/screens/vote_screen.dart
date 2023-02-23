import 'package:elector/constants/constants.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/screens/ongoing_election.dart';
import 'package:elector/screens/upcoming_election.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: kMainThemeColor,
            toolbarHeight: 75,
            title: Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(userStream);
                return user.when(
                  data: (data) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Vote'),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(data.imageUrl),
                          ),
                        ],
                      ),
                    );
                  },
                  error: (err, stack) => Text('$err'),
                  loading: () => CircularProgressIndicator(
                    color: kMainThemeColor,
                  ),
                );
              },
            ),
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
                    text: 'Ongoing elections',
                  ),
                  Tab(
                    text: 'Upcoming elections',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              OngoingElectionPage(),
              UpcomingElectionPage(),
            ],
          )),
    );
  }
}
