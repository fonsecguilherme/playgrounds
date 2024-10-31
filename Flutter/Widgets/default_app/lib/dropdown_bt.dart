import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const Mat3AppWidget());
}

class Mat3AppWidget extends StatefulWidget {
  const Mat3AppWidget({super.key});

  @override
  State<Mat3AppWidget> createState() => _Mat3AppWidgetState();
}

class _Mat3AppWidgetState extends State<Mat3AppWidget> {
  @override
  Widget build(BuildContext context) {
    final List<String> list = [
      'Guilherme',
      'Nicole',
      'Selma',
      'Genivaldo',
      'bibi'
    ];

    String dropdownvalue = 'bibi';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('APPBAR'),
          centerTitle: true,
        ),
        body: Center(
          child: DropdownButton<String>(
            // hint: Text(dropdownvalue),
            value: list.first,
            items: list
                .map(
                  (String name) => DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              setState(() {
                dropdownvalue = value!;
                log(dropdownvalue);
              });
            },
          ),
        ),
      ),
    );
  }
}
