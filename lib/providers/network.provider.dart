import 'package:flutter/material.dart';
import 'package:urcoin/models/network.model.dart';
import 'package:urcoin/utils/constants.dart';

class NetworkProvider extends ChangeNotifier {
  //Network options
  final List<NetworkModel> networks = networkOptions.map((option) {
    return NetworkModel.fromJson(option);
  }).toList();
  late NetworkModel _selectedNetwork = networks[0];
  NetworkModel get selectedNetwork => _selectedNetwork;
  void selectNetwork(NetworkModel network) {
    _selectedNetwork = network;
    notifyListeners();
  }
}
