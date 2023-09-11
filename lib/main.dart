// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/providers/compose.provider.dart';
import 'package:urcoin/providers/network.provider.dart';

import 'package:urcoin/providers/utils.provider.dart';
import 'package:urcoin/providers/wallet.provider.dart';

import 'package:urcoin/routes/index.dart' as router;
import 'package:urcoin/themes/index.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ComposeProvider()),
      ChangeNotifierProvider(create: (_) => UtilsStateNotifier()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => WalletProvider()),
      ChangeNotifierProvider(create: (_) => NetworkProvider()),
    ],
    child: const UrCoin(),
  ));
}

class UrCoin extends StatelessWidget {
  const UrCoin({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
    );
  }
}
