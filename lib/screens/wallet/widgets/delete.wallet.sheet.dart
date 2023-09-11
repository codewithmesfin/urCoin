// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';

import 'package:urcoin/utils/colors.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/dialogs/bottom.sheet.sign.dart';

void showDeleteBottomSheet(context, id, userId) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
    backgroundColor: whiteColor,
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: whiteColor,
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const BottomSheetSign(),
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  foregroundColor: Colors.red,
                  backgroundColor: lightColor,
                  child: Icon(Icons.warning),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Delete wallet",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Are you absolutely certain that you wish to proceed with the action of removing your wallet from this application? Please be aware that this action will permanently delete your wallet data, including any stored information or transactions associated with it. This cannot be undone, and you may lose access to important financial data. Do you still want to proceed?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Consumer<WalletProvider>(
                      builder: (context, walletProvider, _) {
                        return Expanded(
                          child: CustomButton(
                            radius: 30.0,
                            color: Colors.red,
                            onPressed: () async {
                              bool success =
                                  await walletProvider.deleteWallet(id, userId);
                              if (success) {
                                Navigator.pushNamed(context, '/home');
                              } else {
                                showAlertDialog(
                                  context,
                                  'Deletion error',
                                  "Dear Customer, we regret to inform you that we were unable to delete your wallet. Please try again.",
                                );
                              }
                            },
                            text: "Delete",
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                        child: CustomButton(
                      radius: 30.0,
                      haveBorder: true,
                      color: whiteColor,
                      onPressed: () => Navigator.pop(context),
                      text: "Cancel",
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
    },
  );
}
