import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poc_caed/route.gr.dart';

import '../setup_locator.dart';
import 'counter_controller.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: const Text('Home page tela'),
          ),
          ElevatedButton(
            onPressed: () {
              final controller = getIt<CounterController>();

              context.router.push(
                SecondRoute(
                  controller: controller,
                ),
              );
            },
            child: const Text(
              'Ir para a tela 2',
            ),
          )
        ],
      ),
    );
  }
}
