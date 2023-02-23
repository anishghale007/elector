import 'package:elector/constants/constants.dart';
import 'package:flutter/material.dart';

class VerificationContainer extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final dynamic icon;
  final TextEditingController controller;
  bool obscureText = false;
  final TextInputAction textInputAction;
  final dynamic textCapitalization;
  final FormFieldValidator<String>? validator;

  VerificationContainer({
    required this.hint,
    required this.keyboardType,
    this.icon,
    this.textCapitalization,
    required this.controller,
    required this.obscureText,
    required this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
          labelText: hint,
          hintStyle: kHintTextStyle,
          fillColor: kFormFieldColor,
          filled: true,
          suffixIcon: icon,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
