import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.noButton = false,
  });
  final String title;
  final String subtitle;
  final bool noButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sync_problem, size: 100, color: secondaryColor),
          const SizedBox(height: 60),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.bold, color: secondaryColor),
          ),
          const SizedBox(height: 20),
          Text(
            style: Theme.of(context).textTheme.bodyMedium,
            subtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Container(
            child: noButton
                ? null
                : CustomButton(
                    radius: 30.0,
                    text: "Go back",
                    color: secondaryColor,
                    onPressed: () => Navigator.pop(context),
                  ),
          ),
        ],
      ),
    );
  }
}
