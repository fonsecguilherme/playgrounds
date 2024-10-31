import 'package:flutter/material.dart';

import 'inherited_theme.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Second Page'),
        ),
        body: Container(
          height: 150,
          width: 150,
          color: ColorWidget.of(context)!.color,
        ),
      );
}
