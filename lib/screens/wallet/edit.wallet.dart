// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/wallet.model.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/formatter.dart';
import 'package:urcoin/utils/image.uri.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/inputs/text.field.dart';

class EditWallet extends StatelessWidget {
  EditWallet({super.key, this.arg});
  final arg;
  final TextEditingController walletNameController = TextEditingController();
  final TextEditingController walletAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    walletNameController.text = arg.name;
    walletAddressController.text = formatHex(arg.address, 10, 4);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_document, color: primaryColor),
            const SizedBox(width: 5),
            Text(
              "Edit wallet name",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Image.asset(image1),
            ),
            const SizedBox(height: 60),
            CustomTextField(
              controller: walletNameController,
              label: "Wallet Name",
              prefix: const Icon(
                Icons.wallet_outlined,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 60),
            CustomTextField(
              controller: walletAddressController,
              label: 'Wallet Public Address',
              prefix: const Icon(
                Icons.wallet_outlined,
                color: primaryColor,
              ),
              disabled: true,
            ),
            const SizedBox(height: 60),
            Consumer<WalletProvider>(
              builder: (context, provider, _) {
                return CustomButton(
                  radius: 30.0,
                  isLoading: provider.isLoading,
                  disabled: provider.isLoading,
                  text: "Save changes",
                  onPressed: () => _editWallet(context, arg),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _editWallet(BuildContext context, WalletModel payload) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.setLoading(true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final privateKey = payload.key;
    final publicKey = payload.address;

    int userId = int.parse(authProvider.currentUserId);
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    // Add to local database.

    Map<String, dynamic> wallet = {
      "id": payload.id,
      "userId": userId,
      "key": privateKey,
      "address": publicKey,
      "name": walletNameController.text,
      "createdAt": payload.createdAt,
      "updatedAt": currentTime
    };

    try {
      await walletProvider.editWallet(wallet);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      showAlertDialog(
        context,
        'Sign up error',
        "Dear Customer, we regret to inform you that we were unable to finish editing your wallet. Please try again.",
      );
    } finally {
      walletProvider.setLoading(false);
    }
  }
}
