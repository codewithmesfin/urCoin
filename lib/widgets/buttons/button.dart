import 'package:flutter/material.dart';

import 'package:urcoin/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double height;
  final Color color;
  final Widget? icon;
  final double radius;

  final bool haveBorder;
  final double width;
  final bool? isLoading;
  final bool? disabled;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 56.0,
    this.haveBorder = false,
    this.color = primaryColor,
    this.width = double.infinity,
    this.isLoading = false,
    this.disabled,
    this.icon,
    this.radius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: haveBorder ? 0 : 1,
      onPressed: disabled == true ? null : () => onPressed(),
      color: color,
      disabledColor: disabled == false ? color : grayColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: haveBorder
            ? const BorderSide(
                width: 1,
                color: grayColor,
              )
            : BorderSide.none,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading == true
                ? Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Transform.scale(
                      scale: 0.7,
                      child: const CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: icon ?? Container(),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: haveBorder ? primaryColor : whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
