// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/validator.dart';

class PhoneField extends StatelessWidget {
  Function onChange;
  TextEditingController? controller;
  String? placeholder;
  String label;
  String? Function(PhoneNumber?)? validator;
  PhoneField({
    super.key,
    required this.onChange,
    this.controller,
    this.placeholder,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      validator: phoneValidator,
      initialCountryCode: 'ET',
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        hintText: 'e.g. 915981847',
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: lightColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grayColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: redColor),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onChanged: (value) => onChange(value),
    );
  }
}
