// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:urcoin/models/transaction.model.dart';
import 'package:urcoin/services/require.dart';
import 'package:http/http.dart' as http;
import 'package:urcoin/utils/constants.dart';

Future<int> getAccountBalance(String address, String url) async {
  String filter =
      'module=account&action=balance&address=$address&tag=latest&apikey=$etherscanApiKey';
  String uri = "$url?$filter";

  try {
    http.StreamedResponse response = await getAll({}, uri);

    final responseBody = await response.stream.bytesToString();
    final jsonData = json.decode(responseBody);
    final Map<String, dynamic> balance = jsonData;

    return int.parse(balance['result']);
  } catch (e) {
    return 0;
  }
}

Future<List<TransactionModel>?> getTransactions(
    String address, String url) async {
  String filter =
      "module=account&action=txlist&address=$address&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=$etherscanApiKey";
  String uri = "$url?$filter";
  try {
    http.StreamedResponse response = await getAll({"address": address}, uri);

    final responseBody = await response.stream.bytesToString();
    final jsonData = json.decode(responseBody)['result'] as List;

    List<TransactionModel> transactions =
        jsonData.map((json) => TransactionModel.fromJson(json)).toList();

    return transactions;
  } catch (e) {
    return null;
  }
}
