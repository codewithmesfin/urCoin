// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/utils.provider.dart';
import 'package:urcoin/utils/colors.dart';

class BottomToolbar extends StatelessWidget {
  BottomToolbar({
    super.key,
    required this.onPressed,
  });
  final Function onPressed;

  List<String> tabs = [
    "/home",
    "/transactions",
    "send-receive",
    "/learn",
    "/settings"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UtilsStateNotifier>(builder: (context, provider, _) {
      int selectedIndex = provider.selectedIndex;
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet_outlined),
            label: 'Wallets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15,
              child: Icon(Icons.swap_vert),
            ),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primaryColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.black26,
        backgroundColor: whiteColor,
        elevation: 1,
        onTap: (index) {
          provider.updateSelectedIndex(index);
          onPressed(index, tabs[index]);
        },
      );
    });
  }
}
