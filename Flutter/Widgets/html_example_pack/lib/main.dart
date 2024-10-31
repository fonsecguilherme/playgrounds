import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widget from HTML',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Widget from HTML'),
        ),
        body: const HtmlWidget(
          "<p>Hello <b>Flutter oie</b><p>",
        ),
      ),
    );
  }
}
