// ignore: file_names
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  Widget? prefix;
  Widget? suffix;
  Function? onChange;
  TextEditingController? controller;
  String? placeholder;
  String label;
  String? Function(String?)? validator;
  bool obscure;
  bool? isNumber;
  bool? isDescription;
  TextInputType? inputType;
  bool disabled;
  bool autofocus;

  CustomTextField(
      {super.key,
      this.prefix,
      this.suffix,
      this.onChange,
      this.controller,
      this.placeholder,
      required this.label,
      this.validator,
      this.obscure = false,
      this.isNumber,
      this.isDescription,
      this.inputType,
      this.disabled = false,
      this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      validator: validator,
      controller: controller,
      keyboardType: inputType ?? TextInputType.text,
      onChanged: (value) => onChange!(value),
      obscureText: obscure,
      decoration: InputDecoration(
        enabled: !disabled,
        prefixIcon: prefix,
        suffixIcon: suffix,
        isDense: true,
        hintText: placeholder ?? 'Doe',
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
    );
  }
}
