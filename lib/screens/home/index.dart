// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/screens/wallet/add-import.wallet.dart';
import 'package:urcoin/screens/wallet/index.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (context, walletProvider, _) {
        return FutureBuilder(
          future: walletProvider.loadPrivateKey(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              _fetchConversionRate(context);
              return const WalletScreen();
            } else {
              return const AddImportwallet();
            }
          },
        );
      },
    );
  }

  Future<void> _fetchConversionRate(BuildContext context) async {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    walletProvider.getMarketValue("ethereum");
  }
}
