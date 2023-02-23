import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:elector/constants/constants.dart';
import 'package:elector/controller/auth_provider.dart';
import 'package:elector/controller/image_provider.dart';
import 'package:elector/screens/email_verification_screen.dart';
import 'package:elector/widgets/custom_dialog.dart';
import 'package:elector/widgets/form_container.dart';
import 'package:elector/widgets/primary_button.dart';
import 'package:elector/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final voterIdController = TextEditingController();
  final passwordController = TextEditingController();
  final pinController = TextEditingController();
  bool status = false;

  final _form = GlobalKey<FormState>();

  String _selectedGender = "";
  var gender = ['Male', 'Female'];

  String _selectedProvince = "";
  var province = {
    'Province No.1': '1',
    'Madhesh': '2',
    'Bagmati': '3',
    'Gandaki': '4',
    'Lumbini': '5',
    'Karnali': '6',
    'Sudurpaschim': '7',
  };

  List _provinces = [];
  ProvinceDependentDropDown() {
    province.forEach((key, value) {
      _provinces.add(key);
    });
  }

  String _selectedDistrict = "";
  var district = {
    'Bhojpur': '1',
    'Dhankuta': '1',
    'Ilam': '1',
    'Jhapa': '1',
    'Khotang': '1',
    'Morang': '1',
    'Okhaldhunga': '1',
    'Panchthar': '1',
    'Sankhuwasabha ': '1',
    'Solukhumbu': '1',
    'Sunsari': '1',
    'Taplejung': '1',
    'Terhathum': '1',
    'Udayapur ': '1',
    'Sarlahi': '2',
    'Dhanusha': '2',
    'Bara': '2',
    'Rautahat': '2',
    'Saptari 	': '2',
    'Siraha ': '2',
    'Mahottari ': '2',
    'Parsa': '2',
    'Sindhuli': '3',
    'Ramechhap': '3',
    'Dolakha': '3',
    'Bhaktapur': '3',
    'Dhading': '3',
    'Kathmandu': '3',
    'Kavrepalanchok': '3',
    'Lalitpur': '3',
    'Nuwakot': '3',
    'Rasuwa': '3',
    'Sindhupalchok': '3',
    'Chitwan': '3',
    'Makwanpur': '3',
    'Baglung': '4',
    'Gorkha': '4',
    'Kaski': '4',
    'Lamjung': '4',
    'Manang': '4',
    'Mustang': '4',
    'Myagdi': '4',
    'Nawalpur': '4',
    'Parbat': '4',
    'Syangja ': '4',
    'Tanahun': '4',
    'Kapilvastu': '5',
    'Parasi': '5',
    'Rupandehi': '5',
    'Arghakhanchi': '5',
    'Gulmi': '5',
    'Palpa': '5',
    'Dang': '5',
    'Pyuthan': '5',
    'Rolpa': '5',
    'Eastern Rukum': '5',
    'Banke': '5',
    'Bardiya': '5',
    'Western Rukum': '6',
    'Salyan': '6',
    'Dolpa': '6',
    'Humla': '6',
    'Jumla': '6',
    'Kalikot': '6',
    'Mugu': '6',
    'Surkhet': '6',
    'Dailekh': '6',
    'Jajarkot': '6',
    'Achham': '7',
    'Baitadi': '7',
    'Bajhang': '7',
    'Bajura': '7',
    'Dadeldhura': '7',
    'Darchula': '7',
    'Doti': '7',
    'Kailali': '7',
    'Kanchanpur': '7',
  };

  List _districts = [];
  DistrictDependentDropDown(provinceShortName) {
    district.forEach((key, value) {
      if (provinceShortName == value) {
        _districts.add(key);
      }
    });
    _selectedDistrict = _districts[0];
  }

  @override
  void initState() {
    super.initState();
    ProvinceDependentDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainThemeColor,
        elevation: 0,
      ),
      backgroundColor: kMainThemeColor,
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          final image = ref.watch(imageProvider).image;
          return Form(
            key: _form,
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: 120,
                      width: 200,
                      child: Hero(
                        tag: 'elector',
                        child: Image.asset('assets/images/elector_light.png'),
                      ),
                    ),
                    Container(
                      height: 1740,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 45, horizontal: 35),
                            child: Text(
                              'Sign Up',
                              style: kHeadingTextStyle,
                            ),
                          ),
                          SubHeading('Full Name'),
                          FormContainer(
                            hint: 'Full Name',
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please provide your full name';
                              }
                              if (val.length > 40) {
                                return 'Maximum full name length is 40';
                              }
                              return null;
                            },
                          ),
                          kDefaultSizedBox,
                          SubHeading('Gender'),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: DropdownButtonFormField(
                                value: _selectedGender.isNotEmpty
                                    ? _selectedGender
                                    : null,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Gender is required';
                                  }
                                },
                                hint: Text(
                                  "Select",
                                  style: kHintTextStyle,
                                ),
                                decoration: InputDecoration(
                                  fillColor: kFormFieldColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kMainThemeColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                items: gender.map((String gender) {
                                  return DropdownMenuItem(
                                    child: Text(gender),
                                    value: gender,
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedGender = "$newValue";
                                    print(_selectedGender);
                                  });
                                }),
                          ),
                          kDefaultSizedBox,
                          SubHeading('Province'),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: DropdownButtonFormField(
                              value: _selectedProvince.isNotEmpty
                                  ? _selectedProvince
                                  : null,
                              validator: (val) {
                                if (val == null) {
                                  return 'Please select your province';
                                }
                              },
                              hint: Text(
                                "Select",
                                style: kHintTextStyle,
                              ),
                              decoration: InputDecoration(
                                fillColor: kFormFieldColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kMainThemeColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _districts = [];
                                  DistrictDependentDropDown(province[newValue]);
                                  _selectedProvince = "$newValue";
                                  print(_selectedProvince);
                                });
                              },
                              items: _provinces.map((province) {
                                return DropdownMenuItem(
                                  child: new Text(province),
                                  value: province,
                                );
                              }).toList(),
                            ),
                          ),
                          kDefaultSizedBox,
                          SubHeading('District'),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 58,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: DropdownButtonFormField(
                              value: _selectedDistrict,
                              validator: (val) {
                                if (val == null) {
                                  return 'Please select your district';
                                }
                              },
                              hint: Text(
                                "Select",
                                style: kHintTextStyle,
                              ),
                              decoration: InputDecoration(
                                fillColor: kFormFieldColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kMainThemeColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedDistrict = "$newValue";
                                  print(_selectedDistrict);
                                });
                              },
                              items: _districts.map((district) {
                                return DropdownMenuItem(
                                  child: new Text(district),
                                  value: district,
                                );
                              }).toList(),
                            ),
                          ),
                          // DependentAndroidDropDown(),
                          kDefaultSizedBox,
                          SubHeading('Email address'),
                          FormContainer(
                            hint: 'Enter your Email Address',
                            keyboardType: TextInputType.emailAddress,
                            controller: mailController,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                            child: Text(
                              '* Please include a legitimate email account as you will '
                              'need to verify it from your account in order to use '
                              'the application ',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: kMainThemeColor,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                          kDefaultSizedBox,
                          SubHeading('Voter ID'),
                          FormContainer(
                            hint: 'Enter your Vote ID',
                            keyboardType: TextInputType.text,
                            controller: voterIdController,
                            obscureText: false,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.none,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Voter ID is required';
                              }
                            },
                          ),
                          kDefaultSizedBox,
                          SubHeading('Password'),
                          FormContainer(
                            hint: 'Enter your password',
                            keyboardType: TextInputType.emailAddress,
                            controller: passwordController,
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
                            textCapitalization: TextCapitalization.none,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Password is required';
                              }
                              if (val.length > 20) {
                                return 'Maximum password length is 20';
                              }
                              return null;
                            },
                          ),
                          kDefaultSizedBox,
                          SubHeading('PIN'),
                          FormContainer(
                            hint: 'Enter your PIN',
                            keyboardType: TextInputType.number,
                            controller: pinController,
                            obscureText: false,
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.none,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'PIN is required';
                              }
                              if (val.length > 10) {
                                return 'Maximum PIN length is 10';
                              }
                              if (val.length < 4) {
                                return 'Minimum PIN length is 4';
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 10),
                            child: Text(
                              '* Please remember your PIN as you will need it to verify '
                              'your vote ',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: kMainThemeColor,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                          kDefaultSizedBox,
                          InkWell(
                            onTap: () {
                              ref.read(imageProvider).getImage();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                          SizedBox(height: 50),
                          PrimaryButton(
                            text: 'Sign Up',
                            onPress: () async {
                              _form.currentState!.save();
                              if (_form.currentState!.validate()) {
                                if (image == null) {
                                  Get.dialog(
                                    CustomDialog(
                                      icon: Icons.image_aspect_ratio,
                                      title: 'Image Required',
                                      description:
                                          'Please Upload your profile picture',
                                      buttonText: 'Ok',
                                    ),
                                  );
                                } else {
                                  FocusScope.of(context).unfocus();
                                  final response = await ref
                                      .read(authProvider)
                                      .userSignUp(
                                        fullName: nameController.text.trim(),
                                        gender: _selectedGender,
                                        province: _selectedProvince,
                                        district: _selectedDistrict,
                                        email: mailController.text.trim(),
                                        voterId: voterIdController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        pin: pinController.text.trim(),
                                        image: image,
                                      );
                                  ref.refresh(authProvider);
                                  if (response == 'Voter ID is already taken') {
                                    Get.dialog(CustomDialog(
                                      icon: Icons.report_gmailerrorred,
                                      title: 'Voter ID already taken',
                                      description:
                                          'Please use another Voter ID. If you feel like'
                                          ' someone has taken your Voter ID, please contact '
                                          'Nepal Election Commission or Nepal Police as soon as possible.',
                                      buttonText: 'Close',
                                    ));
                                  } else if (response ==
                                      'Voter ID does not exist') {
                                    Get.dialog(CustomDialog(
                                      icon: Icons.report_gmailerrorred,
                                      title: 'Voter ID does not exist',
                                      description:
                                          'The entered Voter ID does not exist in the database.'
                                          'Please use a valid Voter ID or register your Voter ID in the'
                                          ' electoral roll or vote list',
                                      buttonText: 'Close',
                                    ));
                                  } else if (response == 'Success') {
                                    Get.to(
                                        () => EmailVerificationPage(
                                            password:
                                                passwordController.text.trim()),
                                        transition: Transition.native);
                                  } else {
                                    Get.showSnackbar(GetSnackBar(
                                      duration: Duration(seconds: 2),
                                      title: 'Some error occurred',
                                      message: response,
                                    ));
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
