// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/validator.dart';
import 'package:urcoin/widgets/dialogs/alert.dialog.dart';

class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({Key? key, required this.onSuccess}) : super(key: key);
  final Function onSuccess;

  @override
  _QRCodeScannerState createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QrcodeScanner> {
  String scannedData = '';
  final TextEditingController qrCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> startScanning() async {
    try {
      String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);

      if (barcodeScanResult != '-1') {
        final validAddress = ethereumAddress(barcodeScanResult);
        if (validAddress == null) {
          showAlertDialog(
            context,
            'Invalid QR Code.',
            'Dear customer, the QR code you scanned does not contain a valid public address. Please ensure that you have scanned the correct QR code.',
          );
        } else {
          setState(() {
            widget.onSuccess(validAddress);
            scannedData = 'Scanned data: $barcodeScanResult';
            qrCodeController.text = barcodeScanResult;
          });
        }
      } else {
        setState(() {
          scannedData = 'Scan canceled';
        });
      }
    } catch (e) {
      setState(() {
        scannedData = 'Error scanning QR code: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        startScanning();
      },
      icon: const Icon(
        Icons.qr_code_rounded,
        size: 25,
        color: primaryColor,
      ),
    );
  }
}
