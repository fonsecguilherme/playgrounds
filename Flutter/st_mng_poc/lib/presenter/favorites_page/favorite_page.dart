import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_page_states.dart';
import 'package:st_mng_poc/presenter/favorites_page/favorite_vm.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // late final FavoriteVM _vm;

  FavoriteVM get _favoritePageVm => context.read<FavoriteVM>();

  @override
  void initState() {
    super.initState();

    _favoritePageVm.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FavoritePageStates>(
      valueListenable: _favoritePageVm.state,
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
