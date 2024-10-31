import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var prefs = await SharedPreferences.getInstance();
  var boolKey = 'isFirstTime';
  var isFirstTime = prefs.getBool(boolKey) ?? true;

  runApp(MaterialApp(
      home: isFirstTime ? IntroScreen(prefs, boolKey) : const RegularScreen()));
}

class IntroScreen extends StatelessWidget {
  final SharedPreferences prefs;
  final String boolKey;
  const IntroScreen(this.prefs, this.boolKey, {super.key});

  @override
  Widget build(BuildContext context) {
    prefs.setBool(boolKey, false); // You might want to save this on a callback.
    return const Scaffold(
      body: Center(
        child: Text('primeira tela'),
      ),
    );
  }
}

class RegularScreen extends StatelessWidget {
  const RegularScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: Text('segunda tela'),
        ),
      );
}
