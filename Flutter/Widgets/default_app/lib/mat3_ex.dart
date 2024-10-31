import 'package:flutter/material.dart';

void main() {
  runApp(const Mat3AppWidget());
}

class Mat3AppWidget extends StatelessWidget {
  const Mat3AppWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('APPBAR'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: 100,
                  width: 100,
                ),
                Expanded(
                  child: Container(
                    color: Colors.amber,
                    height: 100,
                    width: 100,
                  ),
                ),
                Container(
                  color: Colors.blue,
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
        ),
      );
}
