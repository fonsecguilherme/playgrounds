import 'dart:developer';

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
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users.elementAt(index);

              return ListTile(
                leading: Text('${user.id}'),
                title: Text(
                  user.name,
                  style: TextTheme.of(context).bodyLarge,
                ),
                subtitle: Text('Idade: ${user.age}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          log('Editar ${user.name}');
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          _favoritePageVm.deleteUser(user);

                          log('Apagando... ${user.name}');
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
