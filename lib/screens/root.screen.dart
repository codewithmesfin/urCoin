// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:urcoin/providers/auth.provider.dart';
import 'package:urcoin/screens/home/index.dart';
import 'package:urcoin/screens/onboarding/index.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return FutureBuilder<bool>(
          future: authProvider.authentiacted(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              return const Home();
            } else {
              return const Onboarding();
            }
          },
        );
      },
    );
  }
}
