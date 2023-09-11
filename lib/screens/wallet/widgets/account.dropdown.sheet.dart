import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/dialogs/bottom.sheet.sign.dart';

void showAccountOptionsModal(
  context,
  Function(Map<String, dynamic> option) onSelect,
) {
  List<Map<String, dynamic>> walletActions = [
    {
      "title": "Edit Account Name",
      "icon": const Icon(Icons.edit_square),
      "route": "/edit-wallet"
    },
    {"title": "View on Etherscan", "icon": const Icon(Icons.open_in_new)},
    {"title": "Share my Public Address", "icon": const Icon(Icons.copy)},
    {
      "title": "Show Private Key",
      "icon": const Icon(Icons.key_outlined),
      "route": "/show-privatekey"
    },
    {"title": "Remove this wallet", "icon": const Icon(Icons.delete)}
  ];

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
                    itemCount: walletActions.length,
                    itemBuilder: (context, index) {
                      final option = walletActions[index];
                      return ListTile(
                          leading: option['icon'],
                          title: Text(
                            option['title'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          onTap: () => onSelect(option));
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
