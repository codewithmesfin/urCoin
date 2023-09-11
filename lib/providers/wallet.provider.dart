// ignore_for_file: depend_on_referenced_packages, library_prefixes

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urcoin/models/transaction.model.dart';
import 'package:urcoin/models/wallet.model.dart';
import 'package:urcoin/sqlite/wallet.db.service.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hex/hex.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:urcoin/services/api.server.dart' as apiService;
import 'package:coingecko_api/coingecko_api.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class WalletAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicKey(String privateKey);
}

class WalletProvider extends ChangeNotifier {
  late WalletModel _wallet = WalletModel(
    id: -1,
    userId: -1,
    key: '',
    address: '',
    name: '',
    createdAt: -1,
    updatedAt: -1,
  );
  WalletModel get wallet => _wallet;
  late List<WalletModel> _wallets = [];
  List<WalletModel> get wallets => _wallets;
  void setWallet(WalletModel payload) {
    _wallet = payload;
    notifyListeners();
  }

  void setWallets(List<WalletModel> payload) {
    _wallets = payload;
    notifyListeners();
  }

  late bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  //Web3.0 Manipulation
  late String _privateKey = '';
  late String _passphrase = "";
  late EthereumAddress _publicKey =
      EthereumAddress.fromHex("0x71C7656EC7ab88b098defB751B7401B5f6d8976F");

  String get privatekey => _privateKey;
  String get passphrase => _passphrase;
  EthereumAddress get publicKey => _publicKey;

  Future<String> loadPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _privateKey = prefs.getString('privateKey')!;
    await getPublicKey(_privateKey);
    return _privateKey;
  }

  Future<void> clearPrivateKeyLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateKey');
    _privateKey = '';
    notifyListeners();
  }

  String generateMnemonic() {
    _passphrase = bip39.generateMnemonic();
    return _passphrase;
  }

  Future<void> setMnemonic(String data) async {
    _passphrase = data;
    notifyListeners();
  }

  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);
    _publicKey = private.address;
    return _publicKey;
  }

  Future<void> setPublicKey(EthereumAddress data) async {
    _publicKey = data;
    notifyListeners();
  }

  Future<void> setPrivateKey(String payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', payload);
    _privateKey = payload;
    notifyListeners();
  }

  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    _privateKey = HEX.encode(master.key);
    return _privateKey;
  }

  //Get wallet account balance.
  late int _accountBalance = 0;
  int get accountBalance => _accountBalance;
  Future<int> getAccountBalance(String address, String url) async {
    address = address.isEmpty || address == "" ? "$_publicKey" : address;

    final result = await apiService.getAccountBalance(address, url);

    int balance = result;
    _accountBalance = balance;
    return balance;
  }

  late List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  Future<List<TransactionModel>?> getTransactions(
      String address, String url) async {
    List<TransactionModel>? response =
        await apiService.getTransactions(address, url);

    _transactions = response!;
    return response;
  }

  //Market value and Ethereum Conversion factor.
  late double _rate = 0.0;
  double get rate => _rate;
  Future<double> getMarketValue(String coin) async {
    final api = CoinGeckoApi();

    try {
      final result = await api.coins.getCoinOHLC(
        id: coin,
        vsCurrency: 'usd',
        days: 1,
      );
      if (!result.isError) {
        _rate = result.data[0].close;

        return result.data[0].close;
      } else {
        return 1.0;
      }
    } catch (e) {
      return 1.0;
    }
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

  //Index of Current wallet.
  late int _selectedWalletIndex = 0;
  int get selectedWalletindex => _selectedWalletIndex;
  void selectWalletIndex(int index) {
    _selectedWalletIndex = index;
    notifyListeners();
  }

//Setup Initial Wallet.
  List<WalletModel> setupWallet(wallets) {
    final defaultWallet =
        wallets.where((wallet) => wallet["key"] == _privateKey).toList();
    final defaultIndex =
        wallets.indexWhere((wallet) => wallet["key"] == _privateKey);

    final currentWallets = List<WalletModel>.from(
        wallets.map((json) => WalletModel.fromJson(json)));

    final currentWalletsFiltered = List<WalletModel>.from(
        defaultWallet.map((json) => WalletModel.fromJson(json)));
    if (_wallet.id < 0 && wallets.isNotEmpty) {
      _selectedWalletIndex = defaultIndex;
      _wallet = currentWalletsFiltered[0];
    }
    return currentWallets;
  }

  //Make the new wallet a default on Create.
  void setupNewWalletDefault(wallets, key) {
    final defaultWallet =
        wallets.where((wallet) => wallet["key"] == key).toList();
    final defaultIndex = wallets.indexWhere((wallet) => wallet["key"] == key);

    final currentWallets = List<WalletModel>.from(
        wallets.map((json) => WalletModel.fromJson(json)));

    final currentWalletsFiltered = List<WalletModel>.from(
        defaultWallet.map((json) => WalletModel.fromJson(json)));

    _selectedWalletIndex = defaultIndex;
    _wallet = currentWalletsFiltered[0];
    _wallets = currentWallets;
  }

//Setup default wallet after one is deleted.
  void setupDefaultWalletAfterDeletion(wallets) {
    if (wallets.length > 0) {
      final currentWallets = List<WalletModel>.from(
          wallets.map((json) => WalletModel.fromJson(json)));

      final currentWalletsFiltered = List<WalletModel>.from(
          wallets.map((json) => WalletModel.fromJson(json)));

      _selectedWalletIndex = 0;
      _wallet = currentWalletsFiltered[0];
      _wallets = currentWallets;
    }
  }

//Interact with Sqlite database.

  //1. fetch my wallets
  Future<List<WalletModel>> fetchMywallets(String id) async {
    try {
      final wallets =
          await WalletDatabaseHelper.getWalletByUserId(int.parse(id));

      return setupWallet(wallets);
    } catch (e) {
      return [];
    }
  }

//2. Edit wallet information.
  Future<bool> editWallet(Map<String, dynamic> payloada) async {
    try {
      await WalletDatabaseHelper.updateItem(payloada);
      WalletModel updatedWalletData = WalletModel(
          id: payloada['id'],
          userId: payloada['userId'],
          key: payloada['key'],
          address: payloada['address'],
          name: payloada['name'],
          createdAt: payloada['createdAt'],
          updatedAt: payloada['updatedAt']);
      _wallet = updatedWalletData;
      return false;
    } catch (e) {
      return false;
    }
  }

  //3. Add a wallet
  Future<bool> addWallet(Map<String, dynamic> payloada) async {
    try {
      final response = await WalletDatabaseHelper.createItem(payloada);
      setupNewWalletDefault(response, payloada['key']);
      return true;
    } catch (e) {
      return false;
    }
  }

  //4. delete wallet
  Future<bool> deleteWallet(int id, String userId) async {
    try {
      final wallets = await WalletDatabaseHelper.deleteItem(id, userId);
      setupDefaultWalletAfterDeletion(wallets);
      return true;
    } catch (e) {
      return false;
    }
  }
}
