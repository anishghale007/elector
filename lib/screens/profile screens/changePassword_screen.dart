import 'package:elector/api/local_auth_api.dart';
import 'package:elector/controller/user_provider.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/verification_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final newPasswordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();
  final email = FirebaseAuth.instance.currentUser!.email;

  Future<String> authenticate() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      storage.delete(key: 'email');
      storage.delete(key: 'password');
      storage.delete(key: 'usingBiometric');
      storage.write(key: 'email', value: email);
      storage.write(
          key: 'password', value: newPasswordController.text.toString());
      storage.write(key: 'usingBiometric', value: 'true');
    }
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: VerificationContainer(
                      hint: 'Enter old password',
                      keyboardType: TextInputType.text,
                      controller: oldPasswordController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Please enter your old password';
                        }
                      },
                    ),
                  ),
                  VerificationContainer(
                    hint: 'Enter new password',
                    keyboardType: TextInputType.text,
                    controller: newPasswordController,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.none,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your new password';
                      }
                    },
                  ),
                  SizedBox(height: 100),
                  PrimaryButton(
                      text: 'Change Password',
                      onPress: () async {
                        _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          final response1 = await authenticate();
                          if (response1 == 'Success') {
                            final response = await ref
                                .read(userProvider)
                                .changePassword(
                                    newPassword:
                                        newPasswordController.text.toString(),
                                    oldPassword:
                                        oldPasswordController.text.toString());
                            if (response == 'Success') {
                              Navigator.of(context).pop();
                              Get.dialog(CustomDialog(
                                  icon: Icons.error,
                                  title: 'Password Changed',
                                  description:
                                      'Your Password has been successfully changed.',
                                  buttonText: 'Close'));
                            } else {
                              Get.dialog(CustomDialog(
                                  icon: Icons.error,
                                  title: 'Some error occurred',
                                  description: response,
                                  buttonText: 'Close'));
                            }
                          }
                        }
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
