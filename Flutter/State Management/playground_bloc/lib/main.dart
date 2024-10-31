import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground_bloc/bloc/counter_bloc.dart';

import 'bloc/counter_event.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = context.read<CounterBloc>();

    return MaterialApp(
      home: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state is CounterUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("bateu pai"),
                duration: Duration(
                  seconds: 1,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<CounterBloc, CounterState>(
                    builder: (context, state) {
                      return Text(state.value.toString());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _customIconBt(
                        onTap: () {
                          counterBloc.add(DecrementEvent());
                        },
                        icon: Icons.remove,
                        color: Colors.red,
                      ),
                      _customIconBt(
                        onTap: () {
                          counterBloc.add(IncrementEvent());
                        },
                        icon: Icons.add,
                        color: Colors.blue,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _customIconBt(
      {required VoidCallback onTap,
      required IconData icon,
      required Color color}) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(icon),
      ),
    );
  }
}
