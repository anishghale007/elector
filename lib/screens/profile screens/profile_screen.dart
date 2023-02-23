import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/auth_provider.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/screens/profile%20screens/aboutUs_screen.dart';
import 'package:elector/screens/profile%20screens/changePassword_screen.dart';
import 'package:elector/screens/profile%20screens/editProfile_screen.dart';
import 'package:elector/screens/profile%20screens/faq_screen.dart';
import 'package:elector/screens/login_screen.dart';
import 'package:elector/screens/profile%20screens/qrCode_screen.dart';
import 'package:elector/screens/profile%20screens/votingHistory_screen.dart';
import 'package:elector/widgets/profile_listTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends ConsumerWidget {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? docId;

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userStream);
    return user.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
            backgroundColor: kMainThemeColor,
            elevation: 0,
          ),
          backgroundColor: kMainThemeColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 40),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          data.imageUrl,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.fullName,
                              style: kSubHeadingTextStyle.copyWith(
                                  fontSize: 25, color: Colors.white),
                            ),
                            Text(
                              data.district + ', ' + data.province,
                              style: kSubHeadingTextStyle.copyWith(
                                  fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Voter ID: ' + data.voterId,
                              style: kSubHeadingTextStyle.copyWith(
                                  fontSize: 15, color: Colors.white),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                      size: 17,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  ' + data.email,
                                    style: kSubHeadingTextStyle.copyWith(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where('userId', isEqualTo: uid)
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      docId = snapshot.data.docs[0].reference.id.toString();
                      return Text(
                        snapshot.data.docs[0].reference.id.toString(),
                        style: TextStyle(color: Colors.transparent, fontSize: 1),
                      );
                    }
                  },
                ),
                ProfileListTile(
                  icon: Icons.account_circle,
                  title: 'Edit Profile',
                  onPress: () {
                    Get.to(() => EditProfileScreen(), transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: Icons.history,
                  title: 'Voting History',
                  onPress: () {
                   Get.to(() => VotingHistoryScreen(docId: docId!), transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: FontAwesomeIcons.circleQuestion,
                  title: 'FAQ',
                  onPress: () {
                    Get.to(() => FaqScreen(), transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: FontAwesomeIcons.lock,
                  title: 'Security',
                  onPress: () {
                    Get.to(() => ChangePasswordScreen(), transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: Icons.info,
                  title: 'About Us',
                  onPress: () {
                    Get.to(() => AboutUsScreen(),
                        transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: Icons.qr_code,
                  title: 'Share the app via QR code',
                  onPress: () {
                    Get.to(() => QRCodeScreen(), transition: Transition.native);
                  },
                ),
                ProfileListTile(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onPress: () {
                    ref.read(authProvider).signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => LoginScreen())));
                  },
                ),
              ],
            ),
          ),
        );
      },
      error: (err, stack) => Text('$err'),
      loading: () => CircularProgressIndicator(
        color: kMainThemeColor,
      ),
    );
  }
}
