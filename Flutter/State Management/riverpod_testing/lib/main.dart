import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final helloWorldProvider = Provider((_) => 'Hello World! Riverpod');

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: MaterialApp(
        home: MainApp(),
      ),
    ),
  );
}

// // Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
// class MainApp extends ConsumerWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final String value = ref.watch(helloWorldProvider);

//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Text(value),
//         ),
//       ),
//     );
//   }
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Add a Consumer
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        // 2. specify the builder and obtain a WidgetRef
        builder: (_, WidgetRef ref, __) {
          // 3. use ref.watch() to get the value of the provider
          final helloWorld = ref.watch(helloWorldProvider);
          return Center(
            child: Text(helloWorld, style: const TextStyle(fontSize: 16)),
          );
        },
      ),
    );
  }
}
