// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class AddImportwallet extends StatelessWidget {
  const AddImportwallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Add or Import wallet",
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
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(image1),
            ),
            const SizedBox(height: 60),
            CustomButton(
              icon: const Icon(Icons.double_arrow_outlined, color: whiteColor),
              radius: 30.0,
              text: "Import From Seed",
              onPressed: () => Navigator.pushNamed(context, '/import-seed'),
              color: greenColor,
            ),
            const SizedBox(height: 40),
            CustomButton(
              icon: const Icon(Icons.add_circle_outline, color: primaryColor),
              radius: 30.0,
              haveBorder: true,
              color: whiteColor,
              text: "Create New Wallet",
              onPressed: () => Navigator.pushNamed(context, '/create-wallet'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
