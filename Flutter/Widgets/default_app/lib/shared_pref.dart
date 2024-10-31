// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({super.key});

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  void setBooleanValue(bool newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('myBooleanKey', newValue);
  }

  Future<bool> getBooleanValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('myBooleanKey') ?? false;
  }

  bool myBooleanValue = false; // Initialize with the default value

  @override
  void initState() {
    super.initState();
    // Retrieve the boolean value from SharedPreferences when the widget is initialized
    getBooleanValue().then((value) {
      setState(() {
        myBooleanValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('My Boolean Value: $myBooleanValue'),
            ElevatedButton(
              onPressed: () {
                // Toggle the boolean value and save it to SharedPreferences
                setBooleanValue(!myBooleanValue);
                setState(() {
                  myBooleanValue = !myBooleanValue;
                });
              },
              child: const Text('Toggle Boolean Value'),
            ),
          ],
        ),
      ),
    );
  }
}
