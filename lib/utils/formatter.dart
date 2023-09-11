// ignore_for_file: depend_on_referenced_packages

import 'package:web3dart/web3dart.dart';
import 'package:intl/intl.dart';

String formatNumber(double number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double thousands = number / 1000;
    return '${thousands.toStringAsFixed(2)}K';
  } else if (number < 1000000000) {
    double thousands = number / 1000000;
    return '${thousands.toStringAsFixed(2)}M';
  } else {
    double millions = number / 1000000000;
    return '${millions.toStringAsFixed(2)}B';
  }
}

String formatInteger(double number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 1000000) {
    double thousands = number / 1000;
    return '${thousands.toStringAsFixed(0)}K';
  } else if (number < 1000000000) {
    double thousands = number / 1000000;
    return '${thousands.toStringAsFixed(0)}M';
  } else {
    double millions = number / 1000000000;
    return '${millions.toStringAsFixed(0)}B';
  }
}

String formatHex(String address, int startChars, int endChars) {
  if (address.length < startChars + endChars + 4) {
    return address;
  }
  final prefix = address.substring(0, startChars + 2);
  final suffix = address.substring(address.length - endChars);
  return '$prefix...$suffix';
}

double formatEther(String number) {
  try {
    BigInt? balanceBigInt = BigInt.tryParse(number);

    if (balanceBigInt == null) {
      return 0.0;
    }

    EtherAmount weiBalance =
        EtherAmount.fromBigInt(EtherUnit.wei, balanceBigInt);
    String latestEther = weiBalance.getValueInUnit(EtherUnit.ether).toString();

    return double.parse(latestEther);
  } catch (e) {
    return 0.0;
  }
}

formatTimestampToDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('MMM d, y, hh:mm a').format(dateTime);
}
