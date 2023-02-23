import 'package:elector/constants/constants.dart';
import 'package:elector/screens/home_screen.dart';
import 'package:elector/screens/profile%20screens/profile_screen.dart';
import 'package:elector/screens/vote_screen.dart';
import 'package:elector/screens/vote_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List pages = [HomeScreen(), VoteScreen(), VoteStatsScreen(), ProfileScreen()];

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<bool> showExitPopup() async {
    return await Get.dialog(
      AlertDialog(
        title: Text('Exit App'),
        content: Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          selectedItemColor: kMainThemeColor,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
                label: 'Vote',
                icon: FaIcon(
                  FontAwesomeIcons.checkToSlot,
                  size: 20,
                )),
            BottomNavigationBarItem(
                label: 'Vote Stats',
                icon: FaIcon(
                  FontAwesomeIcons.chartColumn,
                  size: 20,
                )),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.account_circle,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
