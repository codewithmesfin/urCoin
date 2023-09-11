import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    super.key,
    this.title = "Coming Soon!",
    this.subtitle =
        "Exciting things are on the horizon! Our talented team is working hard to implement a brand-new screen for our Flutter app. Please bear with us a little longer as we perfect it. Thank you for your patience! 🚀",
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 200,
                maxHeight: 250,
                minWidth: 250,
                maxWidth: 300,
              ),
              child: Image.asset(
                image1,
                fit: BoxFit.fill,
                width: double.infinity,
                alignment: Alignment.topCenter,
              ),
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
            ),
            const SizedBox(height: 30),
            Text(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
              subtitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            CustomButton(
              text: "Go back",
              radius: 30.0,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
