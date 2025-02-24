import 'package:bloc_heritage/home/cubit/home_cubit.dart';
import 'package:bloc_heritage/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomePage(),
      ),
    );
  }
}
