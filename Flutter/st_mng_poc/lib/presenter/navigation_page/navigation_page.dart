import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mng_poc/database.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_page.dart';
import 'package:st_mng_poc/presenter/home_page/home_page.dart';
import 'package:st_mng_poc/presenter/navigation_page/navigation_state.dart';
import 'package:st_mng_poc/presenter/navigation_page/navigation_vm.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late final NavigationVm _vm;

  AppDatabase get database => context.read<AppDatabase>();

  @override
  void initState() {
    super.initState();

    _vm = NavigationVm();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _vm.state,
        builder: (context, state, _) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('State Management'),
            backgroundColor: Colors.red,
          ),
          body: switch (state.index) {
            0 => HomePage(),
            1 => FavoritePage(),
            _ => SizedBox.shrink(),
          },
          bottomNavigationBar: NavigationBar(
            selectedIndex: state.index,
            onDestinationSelected: (index) {
              switch (index) {
                case 0:
                  _vm.changeTab(NavigationState.home());
                  break;
                case 1:
                  _vm.changeTab(NavigationState.favorites());
                  break;
                default:
                  _vm.changeTab(NavigationState.home());
              }
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.star), label: 'Fav'),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
