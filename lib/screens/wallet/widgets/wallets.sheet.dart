// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/wallet.model.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/formatter.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/bottom.sheet.sign.dart';

void showWalletskModal(
  context,
  List<WalletModel> items,
  Function(WalletModel option) onSelect,
) {
  final provider = Provider.of<WalletProvider>(context, listen: false);
  const walletLeading = CircleAvatar(
    backgroundColor: greenColor,
    child: Icon(Icons.account_balance_wallet_outlined),
  );

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
          child: Column(children: [
            const BottomSheetSign(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "Accounts",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final wallet = items[index];
                return Container(
                  padding: const EdgeInsets.only(left: 5),
                  color: provider.selectedWalletindex == index
                      ? primaryColor
                      : whiteColor,
                  child: Container(
                    color: provider.selectedWalletindex == index
                        ? lightColor
                        : whiteColor,
                    child: ListTile(
                      leading: walletLeading,
                      title: Text(
                        wallet.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: provider.selectedWalletindex == index
                                    ? primaryColor
                                    : blackColor),
                      ),
                      subtitle: Text(
                        formatHex(wallet.address, 4, 4),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: GestureDetector(
                        onTap: () => _coppyToClipboard(
                            context, wallet.address, "Address"),
                        child: const Icon(Icons.copy),
                      ),
                      onTap: () async {
                        provider.setWallet(wallet);
                        await provider.setPrivateKey(wallet.key);
                        provider.selectWalletIndex(index);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                radius: 30.0,
                haveBorder: true,
                color: whiteColor,
                text: "Add account or import wallet",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/add-import-wallet');
                },
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 20),
          ]),
        ),
      );
    },
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

  Navigator.pop(context);
}
