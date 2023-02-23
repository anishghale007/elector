import 'package:elector/constants/constants.dart';
import 'package:elector/controller/federal_provider.dart';
import 'package:elector/screens/party_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class PartyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'List of Political Parties',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final partyStream = ref.watch(prProvider);
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              partyStream.when(
                data: (data) {
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 2 / 2.5,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final dat = data[index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                                () => PartyDetailsScreen(
                                    image: dat.imageUrl,
                                    partyFullName: dat.partyFull,
                                    partyShortName: dat.partyName,
                                    partyInfo: dat.partyInfo),
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
                                      borderRadius: BorderRadius.circular(10),
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
                      });
                },
                error: (err, stack) => Text('$err'),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: kMainThemeColor,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
}
