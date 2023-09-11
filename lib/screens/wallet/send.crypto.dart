// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/constants.dart';
import 'package:urcoin/utils/formatter.dart';

import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';
import 'package:urcoin/widgets/inputs/qr.scanner.dart';
import 'package:urcoin/widgets/inputs/text.field.dart';
import 'package:web3dart/web3dart.dart';

class SendCrypto extends StatelessWidget {
  SendCrypto({super.key, this.arg});
  final arg;

  final TextEditingController recipientController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);
    String accountBalance =
        formatEther('${walletProvider.accountBalance}').toStringAsFixed(2);

    amountController.text = accountBalance;
    recipientController.text = arg == "" ? '0x1234...3456' : arg;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Send to",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Text(
              networkProvider.selectedNetwork.title,
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
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    'From:',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: grayColor)),
                    child: TextFormField(
                      controller: amountController,
                      autofocus: true,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.attach_money_rounded,
                          color: primaryColor,
                        ),
                        isDense: true,
                        hintText:
                            'Balance: ${walletProvider.accountBalance} ${networkProvider.selectedNetwork.unit}',
                        labelText:
                            'Amount(${networkProvider.selectedNetwork.unit}) - from ${walletProvider.wallet.name}',
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    'To:',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: grayColor)),
                    child: TextField(
                      controller: recipientController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.public,
                          color: primaryColor,
                        ),
                        suffixIcon: QrcodeScanner(
                            onSuccess: (e) => recipientController.text = e),
                        isDense: true,
                        hintText: '0x1234...3456',
                        labelText: 'Public Address',
                        border: const UnderlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Text(
              "Your Account",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundColor: greenColor,
              foregroundColor: whiteColor,
              child: Icon(Icons.account_balance_wallet_outlined, size: 30),
            ),
            title: Text(
              walletProvider.wallet.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              formatHex(walletProvider.wallet.address, 4, 4),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(20),
        child: Consumer<WalletProvider>(
          builder: (context, provider, _) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: CustomButton(
                text: "Send",
                isLoading: provider.isLoading,
                disabled: provider.isLoading,
                color: primaryColor,
                radius: 30.0,
                onPressed: () {
                  if (recipientController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    String recipient = recipientController.text;
                    double amount = double.parse(amountController.text);
                    BigInt bigIntValue = BigInt.from(amount * pow(10, 18));

                    EtherAmount ethAmount =
                        EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue);
                    _sendTransaction(context, recipient, ethAmount);
                  } else {
                    showAlertDialog(
                      context,
                      'Form validation error',
                      "Receipient address and Amount field must be entered.",
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Future<void> _sendTransaction(
      BuildContext context, String receiver, EtherAmount txValue) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.setLoading(true);
    final privateKey = walletProvider.wallet.key;

    var apiUrl = sepolia_api_key;
    // Replace with your API
    var httpClient = http.Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    EtherAmount gasPrice = await ethClient.getGasPrice();

    try {
      await ethClient.sendTransaction(
        credentials,
        Transaction(
          to: EthereumAddress.fromHex(receiver),
          gasPrice: gasPrice,
          maxGas: 100000,
          value: txValue,
        ),
        chainId: 11155111,
      );
      showAlertDialog(
          context,
          'Success',
          "You have successfully transfered $txValue to $receiver !",
          primaryColor,
          TextButton(
              onPressed: () {
                walletProvider.setLoading(false);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
              child: const Text("Close")),
          true);
      recipientController.text = "";
      amountController.text = "";
    } catch (e) {
      showAlertDialog(
        context,
        'Sending Error',
        "$e",
      );
    } finally {
      walletProvider.setLoading(false);
      await ethClient.dispose();
    }
  }
}
