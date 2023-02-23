import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/screens/federal%20election/federal_candidate_screen.dart';
import 'package:elector/screens/leadership_screen.dart';
import 'package:elector/screens/party_details_screen.dart';
import 'package:elector/screens/party_screen.dart';
import 'package:elector/screens/provincial%20election/provincial_candidate_choose.dart';
import 'package:elector/widgets/candidates_card.dart';
import 'package:elector/widgets/carousel.dart';
import 'package:elector/widgets/leadership_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(builder: (context, ref, child) {
        final user = ref.watch(userStream);
        final partyStream = ref.watch(prProvider);
        return SafeArea(
          child: Column(
            children: [
              user.when(
                data: (data) {
                  return Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.fullName,
                                style: kSubHeadingTextStyle,
                              ),
                              Text(
                                data.district + ', ' + data.province,
                                style: kSubHeadingTextStyle.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              data.imageUrl,
                            ),
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Carousel(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/fair_election.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                height: 7,
                width: double.infinity,
                color: Colors.grey[200],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Parties',
                        style: kHeadingTextStyle.copyWith(fontSize: 22),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => PartyScreen(),
                              transition: Transition.native);
                        },
                        child: Text(
                          'View All',
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              partyStream.when(
                data: (data) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length < 5 ? data.length : 5,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final dat = data[index];
                          return data.isEmpty
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    Get.to(
                                        () => PartyDetailsScreen(
                                              image: dat.imageUrl,
                                              partyInfo: dat.partyInfo,
                                              partyFullName: dat.partyFull,
                                              partyShortName: dat.partyName,
                                            ),
                                        transition: Transition.native);
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 120,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Image.network(
                                              dat.imageUrl,
                                              fit: BoxFit.contain,
                                            ),
                                            height: 95,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          dat.partyName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                  );
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: kMainThemeColor,
                  ),
                ),
              ),
              Container(
                height: 7,
                width: double.infinity,
                color: Colors.grey[200],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Candidates',
                    style: kHeadingTextStyle.copyWith(fontSize: 22),
                  ),
                ),
              ),
              CandidatesCard(
                title: 'Federal Election Candidates',
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3366FF),
                    const Color(0xFF00CCFF),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
                onPress: () {
                  Get.to(() => FederalCandidateScreen(),
                      transition: Transition.rightToLeft);
                },
              ),
              CandidatesCard(
                title: 'Provincial Election Candidates',
                gradient: LinearGradient(
                    colors: [
                      Colors.orange,
                      Colors.orangeAccent,
                      Colors.red,
                      Colors.redAccent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 0.1, 0.5, 0.7] //stops for individual color
                    ),
                onPress: () {
                  Get.to(() => ProvincialCandidateChooseScreen(),
                      transition: Transition.rightToLeft);
                },
              ),
              SizedBox(height: 15),
              Container(
                height: 7,
                width: double.infinity,
                color: Colors.grey[200],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Current Leadership',
                    style: kHeadingTextStyle.copyWith(fontSize: 22),
                  ),
                ),
              ),
              LeadershipCard(
                imagePath: 'assets/images/HOR_Card.png',
                onPress: () {
                  Get.to(() => LeadershipScreen(),
                      transition: Transition.native);
                },
              ),
              LeadershipCard(
                imagePath: 'assets/images/PA_Card.png',
                onPress: () {
                  Get.to(() => LeadershipScreen(),
                      transition: Transition.native);
                },
              ),
              SizedBox(height: 35),
            ],
          ),
        );
      }),
    );
  }
}
