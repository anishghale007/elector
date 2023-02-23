import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/image_provider.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class EditProfileScreen extends ConsumerWidget {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String? docId;

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(userStream);
    final image = ref.watch(imageProvider).image;
    return Scaffold(
      backgroundColor: kMainThemeColor,
      appBar: AppBar(
        backgroundColor: kMainThemeColor,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          user.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(data.imageUrl),
                  ),
                ),
              );
            },
            error: (err, stack) => Text('$err'),
            loading: () => CircularProgressIndicator(
              color: Colors.white,
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
                  style: TextStyle(color: Colors.transparent),
                );
              }
            },
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: double.infinity,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Upload New Profile Picture',
                    style: kSubHeadingTextStyle,
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref.read(imageProvider).getImage();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(15),
                      strokeWidth: 1.0,
                      dashPattern: [5, 5],
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kFormFieldColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: image == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/images/profile_picture.png'),
                                  Text(
                                    'Upload your profile picture',
                                    style: TextStyle(
                                      color: Color(0xFFADADAD),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'maximum size: 2MB',
                                    style: TextStyle(
                                      color: Color(0xFFADADAD),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : Image.file(File(image.path)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                user.when(
                  data: (data) {
                    return PrimaryButton(
                      text: 'Change Profile Picture',
                      onPress: () async {
                        print(docId);
                        if (image == null) {
                          Get.dialog(AlertDialog(
                            title: Text('Image field is null'),
                            content: Text('Please upload a profile picture'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close')),
                            ],
                          ));
                        } else {
                          final response = await ref
                              .read(userProvider)
                              .updateProfile(
                                postId: docId!,
                                image: image,
                                imageId: data.imageId,
                              );
                          if (response == 'Success') {
                            Navigator.of(context).pop();
                          } else {
                            GetSnackBar(
                              title: 'Error',
                              message: response,
                            );
                          }
                        }
                      },
                    );
                  },
                  error: (err, stack) => Text('$err'),
                  loading: () => CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
