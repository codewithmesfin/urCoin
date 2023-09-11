import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/models/network.model.dart';
import 'package:urcoin/providers/network.provider.dart';
import 'package:urcoin/screens/wallet/widgets/network.dropdown.popup.dart';
import 'package:urcoin/utils/colors.dart';

class NetworkToolbarButton extends StatelessWidget {
  const NetworkToolbarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: const BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.all(Radius.circular(60))),
      child: Consumer<NetworkProvider>(builder: (context, provider, _) {
        List<NetworkModel> networks = provider.networks;
        NetworkModel network = provider.selectedNetwork;

        return GestureDetector(
          onTap: () => showNetworkModal(
              context,
              networks,
              (e) => {
                    provider.selectNetwork(e),
                    Navigator.pop(context),
                  }),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 13,
                      backgroundColor: network.color,
                      child: network.icon,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        provider.selectedNetwork.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.expand_more_outlined,
                color: Colors.black38,
              ),
            ],
          ),
        );
      }),
    );
  }
}
