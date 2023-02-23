import 'package:elector/api/local_auth_api.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/auth_provider.dart';
import 'package:elector/screens/email_verification_screen.dart';
import 'package:elector/screens/main_screen.dart';
import 'package:elector/screens/registration_screen.dart';
import 'package:elector/screens/reset_password_screen.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:elector/widgets/form_container.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool status = false;

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final LocalAuthentication auth = LocalAuthentication();
  bool userHasFingerprint = false;

  void getSecureStorage() async {
    final isUsingBio = await storage.read(key: 'usingBiometric');
    setState(() {
      userHasFingerprint = isUsingBio == 'true';
    });
  }

  Future<String> authenticate() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      final userStoredEmail = await storage.read(key: 'email');
      Get.to(() => MainScreen(), transition: Transition.leftToRight);
    }
    return 'Success';
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    getSecureStorage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kMainThemeColor,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              return Form(
                key: _form,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Hero(
                              tag: 'elector',
                              child: Image.asset(
                                  'assets/images/elector_light.png'),
                            ),
                          ),
                        ),
                        Container(
                          height: 650,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(40, 40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 45, horizontal: 35),
                                child: Text(
                                  'Sign In',
                                  style: kHeadingTextStyle,
                                ),
                              ),
                              SubHeading('Email address'),
                              FormContainer(
                                hint: 'Enter your Email address',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                obscureText: false,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.none,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!val.contains('@')) {
                                    return 'Please provide a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 12),
                              SubHeading('Password'),
                              FormContainer(
                                hint: 'Enter your password',
                                keyboardType: TextInputType.emailAddress,
                                controller: passwordController,
                                textCapitalization: TextCapitalization.none,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                                icon: IconButton(
                                  icon: status == false
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: kMainThemeColor,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      if (status == false) {
                                        status = true;
                                      } else {
                                        status = false;
                                      }
                                    });
                                  },
                                ),
                                obscureText: status == false ? true : false,
                                textInputAction: TextInputAction.done,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => ResetPasswordScreen(),
                                            transition: Transition.leftToRight);
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: PrimaryButton(
                                  text: 'Sign In',
                                  onPress: () async {
                                    _form.currentState!.save();
                                    if (_form.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      final response = await ref
                                          .read(authProvider)
                                          .loginUser(
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                          );
                                      if (response != 'Success') {
                                        Get.dialog(CustomDialog(
                                          buttonText: 'Close',
                                          description: response,
                                          title: 'Some error occurred',
                                          icon: Icons.error,
                                        ));
                                      } else {
                                        Get.to(
                                            () => EmailVerificationPage(
                                                password: passwordController
                                                    .text
                                                    .trim()),
                                            transition: Transition.native);
                                      }
                                    }
                                  },
                                ),
                              ),
                              userHasFingerprint
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            final response =
                                                await authenticate();
                                            if (response == 'Success') {
                                              String? email = await storage
                                                  .read(key: 'email');
                                              String? password = await storage
                                                  .read(key: 'password');
                                              await ref
                                                  .read(authProvider)
                                                  .loginUser(
                                                    email: email!.trim(),
                                                    password: password!.trim(),
                                                  );
                                            }
                                          },
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.fingerprint,
                                                    color: kMainThemeColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '  Tap to Login with Fingerprint',
                                                  style: TextStyle(
                                                    color: kMainThemeColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Spacer(),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don\'t have an account? ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() => RegistrationScreen(),
                                                transition: Transition.zoom);
                                          },
                                          child: Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              color: kMainThemeColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              userHasFingerprint
                                  ? SizedBox(height: 20)
                                  : SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
