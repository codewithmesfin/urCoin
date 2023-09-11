// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

class WalletOptions extends StatelessWidget {
  WalletOptions({super.key, required this.onPressed});
  final Function onPressed;
  List<Map<String, dynamic>> actions = [
    {
      "title": "Send",
      "route": "/send",
      "icon": const Icon(Icons.file_upload_outlined)
    },
    {
      "title": "Receive",
      "route": "/receive",
      "icon": const Icon(Icons.file_download_outlined)
    },
    {
      "title": "Transactions",
      "route": "/transactions",
      "icon": const Icon(Icons.access_time_filled_sharp)
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: actions.map((action) {
        return GestureDetector(
          onTap: () => onPressed(action),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: lightColor,
                  foregroundColor: primaryColor,
                  radius: 30,
                  child: action['icon'],
                ),
                const SizedBox(height: 10),
                Text(
                  action['title'],
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
