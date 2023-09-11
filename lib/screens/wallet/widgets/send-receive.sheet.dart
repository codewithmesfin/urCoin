import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/network.model.dart';
import 'package:urcoin/providers/wallet.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/dialogs/bottom.sheet.sign.dart';

void showSendReceiveModal(
  context,
  Function(NetworkModel option) onSelect,
) {
  List<Map<String, dynamic>> options = [
    {
      "title": "Send",
      "subtitle": "Send crypto to any account",
      "icon": const Icon(Icons.north_east),
      "route": "/send"
    },
    {
      "title": "Receive",
      "subtitle": "Receive crypto",
      "icon": const Icon(Icons.south_west),
      "route": "/receive"
    },
  ];

  final walletProvider = Provider.of<WalletProvider>(context, listen: false);

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
          child: Column(
            children: [
              const SizedBox(height: 10),
              const BottomSheetSign(),
              Container(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, options[index]['route'],
                              arguments: "${walletProvider.publicKey}");
                        },
                        contentPadding: const EdgeInsets.only(bottom: 10),
                        leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          foregroundColor: whiteColor,
                          child: options[index]['icon'],
                        ),
                        title: Text(
                          options[index]['title'],
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          options[index]['subtitle'],
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
