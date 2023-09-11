// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urcoin/errors/empty.dart';
import 'package:urcoin/models/wallet.model.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/screens/wallet/widgets/account.dropdown.sheet.dart';
import 'package:urcoin/screens/wallet/widgets/delete.wallet.sheet.dart';
import 'package:urcoin/screens/wallet/widgets/network.toolbar.dart';
import 'package:urcoin/screens/wallet/widgets/send-receive.sheet.dart';
import 'package:urcoin/screens/wallet/widgets/wallet.option.dart';
import 'package:urcoin/screens/wallet/widgets/wallets.sheet.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/formatter.dart';
import 'package:urcoin/utils/image.uri.dart';

import 'package:provider/provider.dart';
import 'package:urcoin/widgets/dialogs/bottom.toolbar.dart';
import 'package:urcoin/widgets/dialogs/confirmation.dailog.dart';

import 'package:urcoin/widgets/inputs/qr.scanner.dart';
import 'package:share_plus/share_plus.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    const walletLeading = CircleAvatar(
      radius: 20,
      backgroundColor: primaryColor,
      child: CircleAvatar(
        radius: 19,
        backgroundColor: lightColor,
        foregroundColor: primaryColor,
        child: Icon(Icons.account_balance_wallet_rounded, size: 29),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: Container(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 35,
            child: Image.asset(
              logo,
              height: 28,
              width: 28,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: const NetworkToolbarButton(),
        actions: [
          QrcodeScanner(onSuccess: (e) {
            Navigator.pushNamed(context, '/send', arguments: e);
          }),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Consumer2<WalletProvider, NetworkProvider>(
              builder: (context, provider, networkProvider, _) {
            final userId = authProvider.currentUserId;

            return ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                FutureBuilder<List<WalletModel>>(
                  future: provider.fetchMywallets(userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final selectedWallet = provider.wallet;
                      final wallets = snapshot.data;
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: lightColor, width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            ListTile(
                              onTap: () => showWalletskModal(
                                  context, wallets!, (option) => null),
                              leading: walletLeading,
                              title: Text(
                                selectedWallet.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              trailing: GestureDetector(
                                child: const Icon(Icons.expand_more),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: const Divider(
                                  color: lightColor, thickness: 2),
                            ),
                            ListTile(
                              leading: Text(
                                'Address:',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              title: Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8, bottom: 8),
                                decoration: const BoxDecoration(
                                    color: lightColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(60))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatHex(selectedWallet.address, 4, 4),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: primaryColor),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _coppyToClipboard(context,
                                            selectedWallet.address, "Address");
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              trailing: GestureDetector(
                                  onTap: () => showAccountOptionsModal(context,
                                          (e) async {
                                        if (e['title'] == "View on Etherscan") {
                                          Navigator.pop(context);
                                          await provider.launchURLBrowser(
                                              "https://etherscan.io/address/${selectedWallet.address}");
                                        }
                                        if (e["title"] == "Edit Account Name") {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, '/edit-wallet',
                                              arguments: selectedWallet);
                                        }
                                        if (e["title"] ==
                                            "Remove this wallet") {
                                          Navigator.pop(context);
                                          showDeleteBottomSheet(context,
                                              selectedWallet.id, userId);
                                        }
                                        if (e["title"] == "Show Private Key") {
                                          Navigator.pop(context);

                                          confirmationDialod(
                                              context,
                                              "Warning",
                                              "Warning: Never disclose this key. Anyone with your private keys can steal any assets held in your account.",
                                              () => {
                                                    Navigator.pushNamed(context,
                                                        '/show-privatekey')
                                                  });
                                        }
                                        if (e["title"] ==
                                            "Share my Public Address") {
                                          Navigator.pop(context);
                                          Share.share(selectedWallet.address);
                                        }
                                      }),
                                  child: const Icon(Icons.more_horiz)),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const EmptyWidget(
                        title: 'Oops',
                        subtitle:
                            "Dear customer, urCoin is not able to fetch your wallets.",
                        noButton: true,
                      );
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: provider.getAccountBalance(provider.wallet.address,
                      networkProvider.selectedNetwork.url),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          padding: const EdgeInsets.all(35),
                          height: 350,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    } else {
                      String balance = '${provider.accountBalance}';

                      double rate = provider.rate;
                      String totalETH = formatEther(balance).toStringAsFixed(2);

                      double convertedWithRatio = (formatEther(balance) * rate);
                      String totalUSD = convertedWithRatio.toStringAsFixed(2);

                      return Container(
                        padding: const EdgeInsets.all(15),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '\$${formatNumber(double.parse(totalUSD))}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 7, top: 7),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor, //
                                      width: 1.0,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(60),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await provider.launchURLBrowser(
                                          "https://etherscan.io/address/${provider.wallet.address}");
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Portfolio",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(width: 10),
                                        const Icon(Icons.open_in_new,
                                            color: primaryColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: CircleAvatar(
                                radius: 22,
                                backgroundColor:
                                    networkProvider.selectedNetwork.color,
                                child: networkProvider.selectedNetwork.icon,
                              ),
                              title: Text(
                                networkProvider.selectedNetwork.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                '${formatNumber(double.parse(totalETH))} ${networkProvider.selectedNetwork.unit}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              trailing: Text(
                                '\$${formatNumber(double.parse(totalUSD))}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 30),
                            WalletOptions(
                              onPressed: (e) {
                                Navigator.pushNamed(context, e['route'],
                                    arguments: '');
                              },
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomToolbar(
        onPressed: (e, route) async {
          if (e == 2) {
            showSendReceiveModal(context, (e) => {});
          }
          if (e == 3) {
            _learnEthereum(context);
          }
          if (e == 0 || e == 1 || e == 4 || e == 5) {
            Navigator.pushNamed(context, route);
          }
        },
      ),
    );
  }

  Future<void> _learnEthereum(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.launchURLBrowser("https://ethereum.org/en/defi/");
  }

  Future<void> _coppyToClipboard(
      BuildContext context, String payload, String title) async {
    Clipboard.setData(ClipboardData(text: payload));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title copied to Clipboard'),
      ),
    );

    Navigator.canPop(context);
  }
}
