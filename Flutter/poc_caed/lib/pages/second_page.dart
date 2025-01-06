import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poc_caed/pages/counter_controller.dart';

@RoutePage()
class SecondPage extends StatelessWidget {
  final CounterController controller;

  const SecondPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda tela'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16.0,
          children: [
            const Text('segunda tela'),
            ListenableBuilder(
              listenable: controller,
              builder: (context, child) => Text(controller.getCount.toString()),
            ),
            ElevatedButton(
              onPressed: () => controller.increment(),
              child: const Text('cuida'),
            )
          ],
        ),
      ),
    );
  }
}
