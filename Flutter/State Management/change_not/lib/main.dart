import 'package:change_not/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterModel>(context, listen: false);

    //CounterModel counter = CounterModel();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<CounterModel>(
            builder: (context, count, child) => Text(
              '${count.count}',
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            counter.increment();
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Badge(
                label: Consumer<CounterModel>(builder: (
                  context,
                  count,
                  child,
                ) {
                  return count.count > 99
                      ? const Text('99+')
                      : Text('${count.count}');
                }),
                child: const Icon(Icons.person),
              ),
              label: 'olá',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'olá',
            ),
          ],
        ),
      ),
    );
  }
}
