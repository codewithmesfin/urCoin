// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/network.model.dart';
import 'package:urcoin/models/wallet.model.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class ShowPrivatekey extends StatelessWidget {
  const ShowPrivatekey({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);
    WalletModel wallet = walletProvider.wallet;
    NetworkModel network = networkProvider.selectedNetwork;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Private key",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              network.title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                size: 60,
                color: Colors.orange,
              ),
              const SizedBox(height: 10),
              Text(
                "Warning: Never disclose this key. Anyone with your private keys can steal any assets held in your account.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 10),
                decoration: const BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.all(Radius.circular(60))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        wallet.key,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primaryColor),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () =>
                          _coppyToClipboard(context, walletProvider.passphrase),
                      child: const Icon(Icons.copy, color: primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                text: "Go back",
                onPressed: () => Navigator.pushNamed(context, '/home'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _coppyToClipboard(BuildContext context, payload) async {
    Clipboard.setData(ClipboardData(text: payload));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Private key copied to Clipboard"),
      ),
    );
  }
}
