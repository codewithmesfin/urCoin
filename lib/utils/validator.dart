// ignore_for_file: avoid_print

import 'package:intl_phone_field/phone_number.dart';

String? passwordController;
String? confirmPasswordController;

String? nameValidator(value) {
  RegExp regex = RegExp(r'^.{1,}$');
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  if (!regex.hasMatch(value)) {
    return ("Enter Valid name(Min. 2 Character)");
  }
  return null;
}

String? zipcodeValidator(value) {
  RegExp regex = RegExp(r'^.{5}$');
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  if (!regex.hasMatch(value)) {
    return ("Enter valid zipcode");
  }
  return null;
}

String? streetValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? commentValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? noOfbagsValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? weightValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? aptSuiteValidator(value) {
  return null;
}

String? cityValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? stateValidator(value) {
  if (value!.isEmpty) {
    return ("Field cannot be Empty");
  }
  return null;
}

String? emailValidator(value) {
  if (value!.isEmpty) {
    return ("Please Enter your email");
  }
  // reg expression for email validation
  if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value.trim())) {
    return ("Please Enter a valid email");
  }
  return null;
}

String? phoneValidator(PhoneNumber? value) {
  if (value == null) {
    return 'Please enter a phone number';
  }

  String formattedNumber =
      value.completeNumber.replaceAll(RegExp(r'[^\d+]'), '');

  String pattern = r'^\+[1-9]\d{1,14}$';
  RegExp regExp = RegExp(pattern);

  if (formattedNumber.isEmpty) {
    return 'Please enter a phone number';
  } else if (!regExp.hasMatch(formattedNumber)) {
    return 'Please enter a valid phone number';
  }

  return null;
}

String? passwordValidator(value) {
  RegExp regex = RegExp(r'^.{8,}$');
  if (value!.isEmpty) {
    return ("Password is required for login");
  }
  if (!regex.hasMatch(value)) {
    return ("Enter Valid Password(Min. 8 Character)");
  }
  passwordController = value;
  if (confirmPasswordController != null) {
    confirmPasswordValidator(confirmPasswordController);
  }
  return null;
}

String? confirmPasswordValidator(value) {
  print("i am success $value $passwordController");
  confirmPasswordController = value;
  if (value != passwordController) {
    return "Password don't match $value $passwordController";
  }
  print("i am not success $value");

  return null;
}

String? ethereumAddress(String address) {
  String regexPattern = r'([a-zA-Z0-9_]+):?(0x[a-fA-F0-9]{40})';
  RegExp regex = RegExp(regexPattern);
  Match? match = regex.firstMatch(address);

  if (match != null) {
    // String prefix = match.group(1)!;
    String publicAddress = match.group(2)!;

    return publicAddress;
  } else {
    print('No Ethereum address found in the URI.');
    return null;
  }
}
