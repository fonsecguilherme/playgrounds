import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mng_poc/database.dart';

import 'presenter/navigation_page/navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();

  // await database
  //     .into(database.users)
  //     .insert(UsersCompanion.insert(name: 'Guilherme', age: 29));

  List<User> allUsers = await database.select(database.users).get();

  log('items in database: $allUsers');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Provider(
        create: (context) => AppDatabase(),
        child: const NavigationPage(),
      ),
    ),
  );
}
