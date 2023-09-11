// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';

String baseUrl = '${dotenv.env['MORALIS_URL']}';
String? etherscanApiKey = dotenv.env['ETHER_SCAN_API_KEY'];
String sepolia_api_key = '${dotenv.env['SEPOLIA_API_KEY']}';

List<Map<String, dynamic>> networkOptions = [
  {
    "id": 0,
    "title": "Ethreum Main Network",
    "icon": Image.asset(ethereum),
    "color": primaryColor,
    "url": "https://api.etherscan.io/api",
    "name": "Ethereum",
    "unit": "ETH"
  },
  {
    "id": 1,
    "title": "Sepolia Test Network",
    "icon": const Text(
      "S",
      style: TextStyle(color: whiteColor),
    ),
    "color": const Color(0xffcfb5f1),
    "url": "https://api-sepolia.etherscan.io/api",
    "name": "SepoliaETH",
    "unit": "SEPOLIAETH"
  },
  {
    "id": 2,
    "title": "Goerli Test Network",
    "icon": const Text(
      "G",
      style: TextStyle(color: whiteColor),
    ),
    "color": const Color(0xff219df4),
    "url": "https://api-goerli.etherscan.io/api",
    "name": "GoerliETH",
    "unit": "GOERLIETH"
  },
];
