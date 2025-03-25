import 'package:flutter/material.dart';

import 'home_page_states.dart';
import 'home_page_vm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageVm _vm;

  @override
  void initState() {
    super.initState();
    _vm = HomePageVm();
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

            if (state.user.isNotEmpty) {
              return Center(
                child: Text(
                  'Estado de sucesso... ${state.user.first.name} '
                  'e a idade é: ${state.user.first.age}',
                ),
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
