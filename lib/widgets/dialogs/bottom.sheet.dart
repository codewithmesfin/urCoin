import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

void showBottomSheetModal(context, children) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return Container(
        color: whiteColor,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: children),
        ),
      );
    },
  );
}
