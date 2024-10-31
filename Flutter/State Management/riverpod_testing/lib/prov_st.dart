import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider<String>((_) => 'Hello world');
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    final hellowWorld = ref.read(helloWorldProvider);
    print(hellowWorld);
  }

  @override
  Widget build(BuildContext context) {
    final helloMessage = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Text(helloMessage),
      )),
    );
  }
}
