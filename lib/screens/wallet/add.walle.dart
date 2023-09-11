// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/inputs/text.field.dart';

class CreateWallet extends StatelessWidget {
  CreateWallet({super.key});
  final TextEditingController walletNameController =
      TextEditingController(text: "Lorem Ipsum");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Create a new wallet",
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
            Consumer<WalletProvider>(
              builder: (context, oProvider, _) {
                return CustomButton(
                  radius: 30.0,
                  isLoading: oProvider.isLoading,
                  disabled: oProvider.isLoading,
                  text: "Create your wallet",
                  onPressed: () => _createNewWallet(context),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewWallet(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.setLoading(true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final mnemonic = walletProvider.generateMnemonic();
    final privateKey = await walletProvider.getPrivateKey(mnemonic);
    final publicKey = await walletProvider.getPublicKey(privateKey);
    walletProvider.setPrivateKey(privateKey);
    walletProvider.setMnemonic(mnemonic);
    walletProvider.setPublicKey(publicKey);

    int userId = int.parse(authProvider.currentUserId);
    final currentTime = DateTime.now().microsecondsSinceEpoch;
    // Add to local database.

    Map<String, dynamic> wallet = {
      "userId": userId,
      "key": privateKey,
      "address": '$publicKey',
      "name": walletNameController.text,
      "createdAt": currentTime,
      "updatedAt": currentTime
    };
    bool success = await walletProvider.addWallet(wallet);
    if (success) {
      walletProvider.setLoading(false);
      Navigator.pushNamed(context, '/confirm-wallet-creation');
    } else {
      showAlertDialog(
        context,
        'Wallet ereation error',
        "Dear Customer, we regret to inform you that we were unable to finish creating your wallet. Please try again.",
      );
      walletProvider.setLoading(false);
    }
  }
}
