import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authStatusProvider = StreamProvider.autoDispose(
    (ref) => FirebaseAuth.instance.authStateChanges());

final authProvider = Provider.autoDispose((ref) => AuthProvider());

class AuthProvider {
  CollectionReference dbUser = FirebaseFirestore.instance.collection('users');

  Future<String> userSignUp(
      {required String fullName,
      required String gender,
      required String province,
      required String district,
      required String email,
      required String voterId,
      required String password,
      required String pin,
      required XFile image}) async {
    try {
      isDuplicateVoterId(voterId);
      isNotExistentVoterId(voterId);
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('userImage/$imageId');
      final imageFile = File(image.path);
      await ref.putFile(imageFile);
      final url = await ref.getDownloadURL();
      if (await isDuplicateVoterId(voterId)) {
        return 'Voter ID is already taken';
      } else if (await isNotExistentVoterId(voterId)) {
        return 'Voter ID does not exist';
      } else {
        UserCredential response = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await dbUser.add({
          'Full Name': fullName,
          'Gender': gender,
          'Province': province,
          'District': district,
          'email': email,
          'Voter ID': voterId,
          'PIN': pin,
          'imageUrl': url,
          'imageId': imageId,
          'userId': response.user!.uid,
        });
        return 'Success';
      }
    } on FirebaseAuthException catch (err) {
      print(err);
      return '${err.message}';
    }
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (err) {
      print(err);
      return '${err.message}';
    }
  }

  Future<String> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'Success';
    } on FirebaseAuthException catch (err) {
      return '${err.message}';
    }
  }

  Future<bool> isDuplicateVoterId(String voterId) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('Voter ID', isEqualTo: voterId)
        .get();
    return query.docs.isNotEmpty;
  }

  Future<bool> isNotExistentVoterId(String voterId) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('electoral roll')
        .where('Voter ID', arrayContains: voterId)
        .get();
    return query.docs.isEmpty;
  }
}
