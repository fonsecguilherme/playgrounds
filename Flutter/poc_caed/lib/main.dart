import 'package:flutter/material.dart';
import 'package:poc_caed/route.dart';

import 'setup_locator.dart';

void main() {
  configureDependencies();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
