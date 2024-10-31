import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inhe_wid_imp/inherited_theme.dart';
import 'package:inhe_wid_imp/second_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorWidget(
      color: Colors.grey,
      onColorChange: () {},
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final colorsList = [
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black,
    Colors.purple
  ];

  late Color color;

  Color _getRandomColor() {
    final random = Random();
    final index = random.nextInt(colorsList.length);
    return colorsList[index];
  }

  void onColorChange() {
    setState(() {
      color = _getRandomColor();
    });
    ColorWidget.of(context)?.onColorChange(); // Notifica as mudanças
  }

  @override
  void didChangeDependencies() {
    color = ColorWidget.of(context)!.color;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ColorWidget(
      color: color,
      onColorChange: onColorChange,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Inherited Widget Demo",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ColorCardWidget(key: UniqueKey()),
              ElevatedButton(
                onPressed: () => onColorChange(),
                child: const Text("Change Color"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondPage(),
                    ),
                  );
                },
                child: const Text("navegar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorCardWidget extends StatelessWidget {
  const ColorCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorWidget.of(context)!.color,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 500,
      width: 500,
    );
  }
}
