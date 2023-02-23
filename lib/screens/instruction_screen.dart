import 'package:elector/constants/constants.dart';
import 'package:elector/models/instruction_contents.dart';
import 'package:elector/models/provincial_election.dart';
import 'package:elector/screens/federal%20election/federal_fptp_screen.dart';
import 'package:elector/screens/provincial%20election/provincial_fptp_screen.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructionScreen extends StatefulWidget {
  String electionId;
  String electionType;
  String? province;

  InstructionScreen({
    required this.electionId,
    required this.electionType,
    this.province,
  });

  @override
  State<InstructionScreen> createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            contents[i].image!,
                            fit: BoxFit.cover,
                          ),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        SizedBox(height: 35),
                        Text(
                          contents[i].text!,
                          textAlign: TextAlign.center,
                          style: kSubHeadingTextStyle,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: PrimaryButton(
                text: currentIndex == contents.length - 1
                    ? 'Get Started'
                    : 'Continue',
                onPress: () {
                  if (currentIndex == contents.length - 1) {
                    if(widget.province == "Province 1") {
                      Get.to(() => ProvincialFPTPScreen(
                         electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Madhesh") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Bagmati") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Gandaki") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Lumbini") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Karnali") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else if(widget.province == "Sudurpashchim") {
                      Get.to(() => ProvincialFPTPScreen(
                        electionID: widget.electionId,
                        electionType: widget.electionType,
                        province: widget.province!,
                      ));
                    } else {
                      Get.to(() =>
                          FederalFPTP(electionID: widget.electionId,
                            electionType: widget.electionType,),
                          transition: Transition.native);
                    }
                  }
                  _controller!.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 35 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? kMainThemeColor : Color(0xFFD9D9D9),
      ),
    );
  }
}
