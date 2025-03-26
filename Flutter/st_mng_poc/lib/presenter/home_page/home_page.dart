import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:st_mng_poc/database.dart';

import 'home_page_states.dart';
import 'home_page_vm.dart';

class HomePage extends StatefulWidget {
  final AppDatabase database;

  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageVm _vm;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm = HomePageVm(database: widget.database);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
          valueListenable: _vm.state,
          builder: (context, state, _) {
            if (state.status == UserStatus.error) {
              return Center(child: Text('deu erroooooooooooooooooooooooo'));
            }

            if (state.loading) {
              return Center(child: const Text('carregando...'));
            }

            if (state.user.isEmpty) {
              return Center(child: const Text('Estado inicial...'));
            }

            if (state.status == UserStatus.autenticado) {
              return Column(
                children: [
                  Text('Guilherme'),
                  Text('Guilherme'),
                  TextField(
                    controller: nameController,
                  ),
                  TextField(
                    controller: ageController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log('enviando usuário...');

                      _vm.createUser(
                        name: nameController.text,
                        age: ageController.text,
                      );
                    },
                    child: Text('Criar usuário'),
                  ),
                ],
              );
            }

            return SizedBox.shrink();

            // switch (state.runtimeType) {
            // case const (HomeScreenLoadingState):
            //   return const Center(child: CircularProgressIndicator());
            // case const (HomeScreenSuccessfulState):
            //   final successfulState = state as HomeScreenSuccessfulState;
            //   return Center(child: Text(successfulState.userName));
            // case const (HomeScreenErrorState):
            //   final errorState = state as HomeScreenErrorState;
            //   return Center(child: Text(errorState.errorMessage));
            // default:
            //   return Container();
            // }
          },
        ),
        floatingActionButton: Row(
          spacing: 16.0,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                _vm.resetAppState();
              },
              child: const Text('initial'),
            ),
            FloatingActionButton(
              onPressed: () {
                _vm.errorUserData();
              },
              child: const Text('erro'),
            ),
            FloatingActionButton(
              onPressed: () {
                _vm.onRefreshUserData();
              },
              child: const Text('success'),
            ),
          ],
        ),
      );
}
