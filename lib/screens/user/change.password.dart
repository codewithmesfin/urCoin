// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';
import 'package:urcoin/utils/validator.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/inputs/text.field.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Change password",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Image.asset(
                image1,
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.contain,
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
                    label: "Old Password",
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
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return CustomTextField(
                    onChange: (value) => authProvider.setNewPassword(value),
                    label: "New Password",
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
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              Consumer<AuthProvider>(
                builder: (context, provider, _) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: CustomButton(
                      isLoading: authProvider.isLoading,
                      disabled: authProvider.isLoading ||
                          authProvider.newPassword.isEmpty ||
                          authProvider.password.isEmpty,
                      text: "Submit",
                      color: primaryColor,
                      onPressed: () => _signin(context),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signin(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.setLoading(true);
    final success = await authProvider.changePassword();

    if (success) {
      authProvider.setLoading(false);
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", (Route<dynamic> route) => false);
    } else {
      authProvider.setLoading(false);
      showAlertDialog(
        context,
        'Oops!',
        "Dear Customer, we regret to inform you that we were unable to change your password. Please double-check the correctness of your email and old password and attempt the password changing process again.",
      );
    }
  }
}
