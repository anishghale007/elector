import 'dart:io';

import 'package:elector/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final userStream =
    StreamProvider.autoDispose((ref) => UserProvider().getSingleUser());
final userProvider = Provider.autoDispose((ref) => UserProvider());

class UserProvider {
  CollectionReference dbUsers = FirebaseFirestore.instance.collection('users');

  User singleUser(QuerySnapshot querySnapshot) {
    final singleData = querySnapshot.docs[0].data() as Map<String, dynamic>;
    return User.fromJson(singleData);
  }

  Stream<User> getSingleUser() {
    final uid = auth.FirebaseAuth.instance.currentUser!.uid;
    final user = dbUsers.where('userId', isEqualTo: uid).snapshots();
    return user.map((event) => singleUser(event));
  }

  Future<String> updateProfile(
      {XFile? image, String? imageId, required String postId}) async {
    try {
      if (image != null) {
        final imageFile = File(image.path);
        final ref1 = FirebaseStorage.instance.ref().child('userImage/$imageId');
        await ref1.delete();
        final newImageId = DateTime.now().toString();
        final ref2 =
            FirebaseStorage.instance.ref().child('userImage/$newImageId');
        await ref2.putFile(imageFile);
        final url = await ref2.getDownloadURL();
        await dbUsers.doc(postId).update({
          'imageUrl': url,
          'imageId': newImageId,
        });
      }
      return 'Success';
    } on FirebaseException catch (err) {
      print(err);
      return '';
    }
  }

  Future<String> addVotingHistory(
      {required String postId, required String electionType}) async {
    try {
      CollectionReference dbHistory =
          FirebaseFirestore.instance.collection('users');
      DateTime currentTime = DateTime.now();
      final String votedDate =
          DateFormat('MM/dd/yyyy, hh:mm a').format(currentTime);
      await dbHistory.doc(postId).collection('voting history').add({
        'electionType': electionType,
        'votedDate': votedDate,
      });
      return 'Success';
    } on FirebaseException catch (err) {
      print(err);
      return '';
    }
  }

  Future<String> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final currentUser = auth.FirebaseAuth.instance.currentUser!;
      final cred = auth.EmailAuthProvider.credential(
          email: currentUser.email!, password: oldPassword);
      await currentUser.reauthenticateWithCredential(cred).then((value) async {
        currentUser
            .updatePassword(newPassword)
            .then((_) {
              return 'Success';
        })
            .catchError((error) {
              return '$error';
        });
      }).catchError((err) {
        return '$err';
      });
      return 'Success';
    } on FirebaseException catch (err) {
      print(err);
      return '';
    }
  }
}
