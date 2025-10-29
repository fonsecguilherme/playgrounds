import 'package:flutter/material.dart';
import 'package:vgv_app/bloc/user_bloc.dart';
import 'package:vgv_app/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (context) => UserBloc(), child: HomePage()),
    );
  }
}
