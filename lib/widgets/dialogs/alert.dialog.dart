// ignore_for_file: unused_element

import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context, title, subtitle,
    [color = Colors.red, Widget? otherChild, bool hideCancel = false]) async {
  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        subtitle,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        otherChild ?? Container(),
        hideCancel
            ? Container()
            : TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text("Close"))
      ],
    ),
  );
}
