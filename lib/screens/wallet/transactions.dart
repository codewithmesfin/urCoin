import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/errors/empty.dart';
import 'package:urcoin/models/transaction.model.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/screens/wallet/widgets/send-receive.sheet.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/formatter.dart';
import 'package:urcoin/widgets/dialogs/bottom.toolbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final networkProvider =
        Provider.of<NetworkProvider>(context, listen: false);

    return Consumer<WalletProvider>(
      builder: (context, walletProvider, _) {
        final wallet = walletProvider.wallet;
        final network = networkProvider.selectedNetwork;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Text(
                  "Transaction logs",
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
          ),
          body: SafeArea(
            child: FutureBuilder<List<TransactionModel>?>(
              future:
                  walletProvider.getTransactions(wallet.address, network.url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<TransactionModel> items = snapshot.data ?? [];

                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        TransactionModel item = items[index];
                        int timestamp = int.parse(items[index].timeStamp);
                        String date = formatTimestampToDate(timestamp);
                        bool iamSender = item.from == wallet.address;
                        String status = int.parse(item.txReceiptStatus) == 1
                            ? "Confirmed"
                            : "Failed";

                        String action = iamSender
                            ? "Sent ${network.name}"
                            : "Received ${network.name}";
                        String amount =
                            // item.value;
                            formatEther(item.value).toString();

                        return ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            Text(date),
                            ListTile(
                              onTap: () => launchURLBrowser(
                                  'https://etherscan.io/address/${item.from}'),
                              leading: CircleAvatar(
                                radius: 20,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: whiteColor,
                                  foregroundColor: primaryColor,
                                  child: iamSender
                                      ? const Icon(Icons.north_east)
                                      : const Icon(Icons.south_west),
                                ),
                              ),
                              title: Text(
                                action,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                status,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: greenColor),
                              ),
                              trailing: Column(
                                children: [
                                  Text("$amount ${network.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(
                                      "${formatInteger(double.parse(item.value))} Wei",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const EmptyWidget(
                    title: 'No Transaction',
                    subtitle:
                        "urCoin is in the process of retrieving your transaction history, and as of now, it appears that there is no transaction history available in urCoin.",
                  );
                }
              },
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
      },
    );
  }

  Future<void> _learnEthereum(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.launchURLBrowser("https://ethereum.org/en/defi/");
  }

  //Open link with External browser.
  Future<void> launchURLBrowser(String uri) async {
    var url = Uri.parse(uri);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
