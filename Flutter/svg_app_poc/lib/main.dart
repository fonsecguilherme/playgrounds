import 'package:flutter/material.dart';
import 'package:svg_app_poc/svg_flutter_pack.dart';
import 'package:svg_app_poc/svg_icon.dart';
import 'package:svg_app_poc/svg_michael.dart';
import 'package:svg_app_poc/svg_vector_graphics.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    SvgFlutterPack(),
    SvgIcon(),
    SvgMichael(),
    SvgVectorGraphics(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.red,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'SVG FLUTTER',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'ICON'),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'MICHAEL',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: 'VECTOR GC',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
