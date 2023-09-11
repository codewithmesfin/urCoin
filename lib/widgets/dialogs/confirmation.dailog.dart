import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/buttons/button.dart';

Future<void> confirmationDialod(
  BuildContext context,
  String title,
  String subtitle,
  Function() onConfirm,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title)),
        content: Text(
          subtitle,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          CustomButton(
            radius: 30.0,
            text: "Confirm",
            onPressed: () => {
              Navigator.pop(context),
              onConfirm(),
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            radius: 30.0,
            color: whiteColor,
            haveBorder: true,
            text: "Close",
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}
