// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:urcoin/errors/not.found.dart';
import 'package:urcoin/routes/constants.dart';
import 'package:urcoin/screens/home/index.dart';
import 'package:urcoin/screens/root.screen.dart';
import 'package:urcoin/screens/settings/index.dart';
import 'package:urcoin/screens/user/change.password.dart';
import 'package:urcoin/screens/user/signin.dart';
import 'package:urcoin/screens/user/signup.dart';
import 'package:urcoin/screens/wallet/add-import.wallet.dart';
import 'package:urcoin/screens/wallet/add.walle.dart';
import 'package:urcoin/screens/wallet/confirm.saving.mnemonic.dart';
import 'package:urcoin/screens/wallet/edit.wallet.dart';
import 'package:urcoin/screens/wallet/import.seed.dart';
import 'package:urcoin/screens/wallet/receive.crypto.dart';
import 'package:urcoin/screens/wallet/send.crypto.dart';
import 'package:urcoin/screens/wallet/show.privatekey.dart';
import 'package:urcoin/screens/wallet/transactions.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var arg = settings.arguments;
  switch (settings.name) {
    case root:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const RootScreen());
    case signin:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const Signin());
    case signup:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const Signup());
    case home:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const Home());
    case createWallet:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => CreateWallet());
    case editWallet:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => EditWallet(
                arg: arg,
              ));
    case confirmWalletCreation:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => const ConfirmSavingMnemonic());

    case addImportWallet:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => const AddImportwallet());
    case importSeed:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => const ImportMnemonic());

    case send:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => SendCrypto(
                arg: arg,
              ));
    case receive:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => ReceiveCrypto(
                arg: arg,
              ));

    case transactions:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const Transactions());
    case showPrivatekey:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => const ShowPrivatekey());
    case setting:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const Settings());
    case changePassword:
      return PageRouteBuilder(
          pageBuilder: (_, a1, a2) => const ChangePassword());

    default:
      return PageRouteBuilder(pageBuilder: (_, a1, a2) => const NotFound());
  }
}
