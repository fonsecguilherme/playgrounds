import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_states.dart';
import 'home_page_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  HomePageVm get _homePageVm => context.read<HomePageVm>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: ValueListenableBuilder(
          valueListenable: _homePageVm.state,
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

                      _homePageVm.createUser(
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
                _homePageVm.resetAppState();
              },
              child: const Text('initial'),
            ),
            FloatingActionButton(
              onPressed: () {
                _homePageVm.errorUserData();
              },
              child: const Text('erro'),
            ),
            FloatingActionButton(
              onPressed: () {
                _homePageVm.onRefreshUserData();
              },
              child: const Text('success'),
            ),
          ],
        ),
      );
}
