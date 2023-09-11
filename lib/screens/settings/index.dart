import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/screens/wallet/widgets/delete.wallet.sheet.dart';
import 'package:urcoin/screens/wallet/widgets/network.dropdown.popup.dart';
import 'package:urcoin/screens/wallet/widgets/send-receive.sheet.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/buttons/button.dart';
import 'package:urcoin/widgets/dialogs/bottom.toolbar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);
    final userId = authProvider.currentUserId;
    List<Map<String, dynamic>> items = [
      {
        "title": "Change your password",
        "subtitle":
            "At urCoin, your security is our top priority. To enhance the protection of your assets and personal information, we strongly recommend periodically updating your password.",
        "route": "/change-password",
        "icon": const Icon(Icons.security)
      },
      {
        "title": "Create new wallet",
        "subtitle":
            "Dear customer, you have the option to create a new urCoin wallet account alongside your existing ones, allowing you to easily manage and interact with them.",
        "route": "/create-wallet",
        "icon": const CircleAvatar(
          radius: 11,
          backgroundColor: blackColor,
          child: Icon(Icons.add_sharp, size: 19),
        )
      },
      {
        "title": "Import a wallet account",
        "subtitle":
            "Dear customer, you can import a wallet account into your urCoin wallet and start interacting.",
        "route": "/import-seed",
        "icon": const Icon(Icons.double_arrow_outlined)
      },
      {
        "title": "Edit your wallet",
        "subtitle": "Update your wallet account information",
        "route": "/edit-wallet",
        "icon": const Icon(Icons.edit_document)
      },
      {
        "title": "Delete your wallet",
        "subtitle":
            "Please be aware that deleting your wallet account is irreversible unless you have access to your private key.",
        "icon": const Icon(Icons.delete_sharp)
      },
      {
        "title": "Change your network",
        "subtitle":
            "You have the capability to make adjustments to your default network settings, allowing you to tailor your online experience to better suit your preferences and needs.",
        "icon": const Icon(Icons.swap_horiz_outlined)
      },
      {
        "title": "Show your private key",
        "subtitle":
            "Never disclose this key. Anyone with your private keys can steal any assets held in your account.",
        "route": "/show-privatekey",
        "icon": const Icon(Icons.edit_note)
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  contentPadding: const EdgeInsets.only(left: 15, right: 15),
                  title: Row(
                    children: [
                      item['icon'],
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          item['title'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(item['subtitle'],
                      style: Theme.of(context).textTheme.bodyMedium),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.black45,
                  ),
                  onTap: () {
                    if (item['route'] == null) {
                      if (item['title'] == "Delete your wallet") {
                        showDeleteBottomSheet(
                            context, walletProvider.wallet, userId);
                      }
                      if (item['title'] == "Change your network") {
                        showNetworkModal(
                            context,
                            networkProvider.networks,
                            (e) => {
                                  networkProvider.selectNetwork(e),
                                  Navigator.pop(context),
                                  Navigator.pushNamed(context, '/home'),
                                });
                      }
                    }
                    if (item['route'] == "/edit-wallet") {
                      Navigator.pushNamed(context, '/edit-wallet',
                          arguments: walletProvider.wallet);
                    } else {
                      Navigator.pushNamed(context, item['route'],
                          arguments: walletProvider.wallet.address);
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: lightColor,
                );
              },
            ),
            const SizedBox(height: 30),
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: CustomButton(
                    isLoading: authProvider.isLoading,
                    color: secondaryColor,
                    icon: const Icon(
                      Icons.logout,
                      color: whiteColor,
                    ),
                    radius: 30.0,
                    text: "Sign Out",
                    onPressed: () async {
                      authProvider.setLoading(true);
                      authProvider.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/", (Route<dynamic> route) => false);
                      authProvider.setLoading(false);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomToolbar(onPressed: (e, route) async {
        if (e == 2) {
          showSendReceiveModal(context, (e) => {});
        }
        if (e == 3) {
          _learnEthereum(context);
        }
        if (e == 0 || e == 1 || e == 4 || e == 5) {
          Navigator.pushNamed(context, route);
        }
      }),
    );
  }

  Future<void> _learnEthereum(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.launchURLBrowser("https://ethereum.org/en/defi/");
  }
}
