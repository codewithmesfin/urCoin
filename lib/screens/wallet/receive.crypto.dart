// ignore_for_file: prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code/code/code.dart';

import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/formatter.dart';
import 'package:urcoin/widgets/buttons/button.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveCrypto extends StatelessWidget {
  const ReceiveCrypto({super.key, this.arg});
  final arg;

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);

    final wallet = walletProvider.wallet;
    final network = networkProvider.selectedNetwork;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Receive",
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Code(
              data: wallet.address,
              codeType: CodeType.qrCode(),
            ),
            const SizedBox(height: 40),
            Text(
              "Scan address to receive payment",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.all(Radius.circular(60))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(formatHex(wallet.address, 4, 4)),
                  TextButton.icon(
                    onPressed: () =>
                        _coppyToClipboard(context, wallet.address, "Address"),
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text("Copy"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: CustomButton(
          text: "Share",
          onPressed: () => Share.share(wallet.address),
          radius: 30.0,
          icon: const Directionality(
              textDirection: TextDirection.rtl,
              child: Icon(Icons.reply, color: whiteColor)),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Future<void> _coppyToClipboard(
      BuildContext context, String payload, String title) async {
    Clipboard.setData(ClipboardData(text: payload));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title copied to Clipboard'),
      ),
    );
  }
}
