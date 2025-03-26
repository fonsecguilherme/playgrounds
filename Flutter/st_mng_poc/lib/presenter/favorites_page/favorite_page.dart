import 'package:flutter/material.dart';
import 'package:st_mng_poc/database.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_page_states.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_vm.dart';

class FavoritePage extends StatefulWidget {
  final AppDatabase database;

  const FavoritePage({super.key, required this.database});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late final FavoriteVM _vm;

  @override
  void initState() {
    super.initState();

    _vm = FavoriteVM(database: widget.database);

    _vm.fetchData();
  }

  void didPopNext() {
    super.didChangeDependencies();
    _vm.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FavoritePageStates>(
      valueListenable: _vm.state,
      builder: (context, state, _) {
        if (state.users.isEmpty) {
          return Center(
            child: Text('Nenhum usuário adicionado'),
          );
        } else {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) => Text(
              'Meu nome é ${state.users.elementAt(index).name} e tenho ${state.users.elementAt(index).age} anos',
              style: TextTheme.of(context).bodyLarge,
            ),
          );
        }
      },
    );
  }
}
