import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/network.model.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/widgets/dialogs/bottom.sheet.sign.dart';

void showNetworkModal(
  context,
  List<NetworkModel> items,
  Function(NetworkModel option) onSelect,
) {
  final provider = Provider.of<NetworkProvider>(context, listen: false);
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
                "Select a network",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  List<NetworkModel> options = provider.networks;
                  NetworkModel option = options[index];
                  return Container(
                    padding: const EdgeInsets.only(left: 5),
                    color: provider.selectedNetwork.id == index
                        ? primaryColor
                        : whiteColor,
                    child: Container(
                      color: provider.selectedNetwork.id == index
                          ? lightColor
                          : whiteColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8),
                        leading: CircleAvatar(
                          backgroundColor: option.color,
                          child: option.icon,
                        ),
                        title: Text(
                          option.title.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: provider.selectedNetwork.id == index
                                      ? primaryColor
                                      : blackColor),
                        ),
                        onTap: () => onSelect(option),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 20),
          ]),
        ),
      );
    },
  );
}
