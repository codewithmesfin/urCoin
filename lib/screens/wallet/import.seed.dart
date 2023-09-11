// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';

import 'package:urcoin/widgets/dialogs/alert.dialog.dart';

class ImportMnemonic extends StatelessWidget {
  const ImportMnemonic({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Import passphrase",
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.note_add_outlined, size: 50),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Kindly input the mnemonic passphrase generated during your wallet account creation. It's crucial to note that your wallet recovery relies on recalling the accurate mnemonic phrase",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => walletProvider.setMnemonic(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.security,
                      color: primaryColor,
                    ),
                    isDense: true,
                    labelText: 'Enter your mnemonic phrase',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: lightColor),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: grayColor),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              MaterialButton(
                padding: const EdgeInsets.all(12),
                minWidth: double.infinity,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                color: primaryColor,
                onPressed: () => _import(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.double_arrow_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Import Your Seed",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _import(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    int userId = int.parse(authProvider.currentUserId);
    final currentTime = DateTime.now().microsecondsSinceEpoch;

    final privateKey =
        await walletProvider.getPrivateKey(walletProvider.passphrase);
    final publicKey = await walletProvider.getPublicKey(privateKey);
    walletProvider.setPrivateKey(privateKey);
    walletProvider.setPublicKey(publicKey);
    Map<String, dynamic> wallet = {
      "userId": userId,
      "key": privateKey,
      "address": '$publicKey',
      "name": "Imported walllet",
      "createdAt": currentTime,
      "updatedAt": currentTime
    };
    bool success = await walletProvider.addWallet(wallet);
    if (success) {
      Navigator.pushNamed(context, '/home');
    } else {
      showAlertDialog(
        context,
        'Wallet importing issue',
        "Dear Customer, we regret to inform you that we were unable to finish importing your wallet. Please try again.",
      );
    }

    walletProvider.setLoading(false);
  }
}
