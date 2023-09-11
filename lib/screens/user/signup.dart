// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';
import 'package:urcoin/utils/validator.dart';
import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/inputs/phone.field.dart';
import 'package:urcoin/widgets/inputs/text.field.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                image1,
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                onChange: (value) => authProvider.setFirstName(value),
                label: "First Name",
                placeholder: "John",
                validator: nameValidator,
                prefix: const Icon(
                  Icons.abc,
                  color: primaryColor,
                ),
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                onChange: (value) => authProvider.setLastName(value),
                label: "Last Name",
                placeholder: "Doe",
                validator: nameValidator,
                prefix: const Icon(
                  Icons.abc,
                  color: primaryColor,
                ),
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              PhoneField(
                onChange: (value) =>
                    authProvider.setPhoneNumber(value.completeNumber),
                label: "Phone Number",
                placeholder: "e.g. 915981847",
                validator: phoneValidator,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                onChange: (value) => authProvider.setEmail(value),
                label: "Email Address",
                placeholder: "example@domain.com",
                validator: emailValidator,
                prefix: const Icon(
                  Icons.chat,
                  color: primaryColor,
                ),
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return CustomTextField(
                      onChange: (value) => authProvider.setPassword(value),
                      label: "Password",
                      placeholder: "....",
                      prefix: const Icon(
                        Icons.key,
                        color: primaryColor,
                      ),
                      obscure: !provider.showPassword,
                      suffix: GestureDetector(
                        onTap: () =>
                            provider.setPasswordVisible(!provider.showPassword),
                        child: provider.showPassword
                            ? const Icon(
                                Icons.visibility_off,
                                color: primaryColor,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: primaryColor,
                              ),
                      ));
                },
              ),
              const SizedBox(height: 10),
              Text(
                'Note:',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontStyle: FontStyle.italic),
              ),
              Text(
                'Please store your password securely as it cannot be recovered. If you forget your password, you may permanently lose access to your assets. Remember that you have the option to change your password at any time.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontStyle: FontStyle.italic, color: blackColor),
              ),
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: CustomButton(
                      isLoading: authProvider.isLoading,
                      disabled: authProvider.isLoading ||
                          provider.firstName.isEmpty ||
                          provider.lastName.isEmpty ||
                          provider.phoneNumber.isEmpty ||
                          provider.email.isEmpty ||
                          provider.password.isEmpty,
                      text: "Sign up",
                      color: primaryColor,
                      onPressed: () => _signin(context),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signin'),
                    child: const Text("Sign in"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.setLoading(true);
    final success = await authProvider.signUp();
    if (success) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/signin", (Route<dynamic> route) => false);
    } else {
      showAlertDialog(
        context,
        'Sign up error',
        "Dear Customer, we regret to inform you that we were unable to finish your signup. Please double-check the correctness of your information and attempt the signup process again.",
      );
    }
    authProvider.setLoading(false);
  }
}
