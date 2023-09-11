import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';

class ComposeButton extends StatelessWidget {
  final bool isButtonExpanded;
  final Function onPressed;

  const ComposeButton(
      {super.key, required this.isButtonExpanded, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
        elevation: 10,
        color: primaryColor1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.edit,
                color: blackColor,
              ),
              AnimatedContainer(
                padding: const EdgeInsets.only(left: 8),
                duration: const Duration(milliseconds: 300),
                width: isButtonExpanded ? 100 : 0,
                child: Text(
                  "Send ETH",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: blackColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
