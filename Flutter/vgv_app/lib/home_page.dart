import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vgv_app/bloc/user_bloc.dart';

import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc get userBloc => context.read<UserBloc>();

  @override
  void initState() {
    super.initState();
    userBloc.add(FetchUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          switch (state) {
            case UserInitial():
              return const Center(child: Text('Welcome!'));
            case UserLoading():
              return const Center(child: CircularProgressIndicator());
            case UserLoaded():
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.login),
                    subtitle: Text(user.type),
                    trailing: Image.network(user.avatarUrl),
                  );
                },
              );
            case UserError():
              return Center(child: Text(state.message));
          }
        },
      ),
    );
  }
}
