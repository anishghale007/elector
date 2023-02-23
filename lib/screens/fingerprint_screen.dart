import 'package:elector/api/local_auth_api.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintScreen extends StatefulWidget {
  final String email;
  final String password;

  FingerprintScreen({required this.email, required this.password});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final storage = FlutterSecureStorage();
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
      storage.write(key: 'email', value: widget.email);
      storage.write(key: 'password', value: widget.password);
      storage.write(key: 'usingBiometric', value: 'true');
    }
    return 'Success';
  }

  @override
  void initState() {
    getSecureStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => userHasFingerprint
      ? MainScreen()
      : Scaffold(
          body: ListView(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        color: kMainThemeColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Welcome !!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.1,
                            color: Colors.transparent,
                            child: Text(
                              'Please enable your fingerprint \n sensor for faster login \n and vote verification.',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final response = await authenticate();
                        if (response == 'Success') {
                          Get.to(() => MainScreen(),
                              transition: Transition.native);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.24,
                        margin: EdgeInsets.symmetric(vertical: 80),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: FaIcon(
                            FontAwesomeIcons.fingerprint,
                            color: kMainThemeColor,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Scan your fingerprint',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Tap on the fingerprint to activate \n the fingerprint sensor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFB8B4B4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
}
