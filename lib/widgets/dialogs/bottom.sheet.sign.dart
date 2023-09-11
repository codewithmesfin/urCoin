import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

class BottomSheetSign extends StatelessWidget {
  const BottomSheetSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 6),
        decoration: const BoxDecoration(
            color: grayColor,
            borderRadius: BorderRadius.all(Radius.circular(60))),
        width: 50,
        height: 4,
      ),
    );
  }
}
