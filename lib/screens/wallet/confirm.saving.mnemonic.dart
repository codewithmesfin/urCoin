import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class ConfirmSavingMnemonic extends StatelessWidget {
  const ConfirmSavingMnemonic({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const CircleAvatar(
                radius: 50,
                child: Icon(Icons.done, size: 50),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "Kindly ensure the secure storage of this Mnemonic phrase, as its loss would result in the inability to recover your wallet or access your urCoin account.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 10),
              decoration: const BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.all(Radius.circular(60))),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    walletProvider.passphrase,
                  )),
                  GestureDetector(
                    onTap: () =>
                        _coppyToClipboard(context, walletProvider.passphrase),
                    child: const Icon(Icons.copy, color: primaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
                radius: 30.0,
                text: "Finish",
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (Route<dynamic> route) => false)),
          ],
        ),
      ),
    );
  }

  Future<void> _coppyToClipboard(BuildContext context, mnemonics) async {
    Clipboard.setData(ClipboardData(text: mnemonics));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Mnemonics copied to Clipboard"),
      ),
    );
  }
}
