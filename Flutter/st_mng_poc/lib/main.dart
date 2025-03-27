import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mng_poc/data/drift_database.dart';
import 'package:st_mng_poc/database.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_vm.dart';
import 'package:st_mng_poc/presenter/home_page/home_page_vm.dart';

import 'presenter/navigation_page/navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          Provider(
            create: (context) => AppDatabase(),
          ),
          Provider(
            create: (context) => DriftDatabase(
              database: context.read<AppDatabase>(),
            ),
          ),

          //ViewModel Dependencies
          Provider(
            create: (context) => HomePageVm(
              database: context.read<DriftDatabase>(),
            ),
          ),

          Provider(
            create: (context) => FavoriteVM(
              database: context.read<DriftDatabase>(),
            ),
          ),
        ],
        child: const NavigationPage(),
      ),
    ),
  );
}
