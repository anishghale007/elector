import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final dynamic icon;
  final TextEditingController controller;
  bool obscureText = false;
  final TextInputAction textInputAction;
  final dynamic textCapitalization;
  final FormFieldValidator<String>? validator;

  FormContainer(
      {required this.hint,
      required this.keyboardType,
      this.icon,
      this.textCapitalization,
      required this.controller,
      required this.obscureText,
      required this.textInputAction,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        maxLines: 1,
        cursorColor: kMainThemeColor,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: kHintTextStyle,
          fillColor: kFormFieldColor,
          filled: true,
          suffixIcon: icon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: kMainThemeColor),
          ),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(
          //     Radius.circular(15),
          //   ),
          //   borderSide: BorderSide(color: Colors.transparent),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
