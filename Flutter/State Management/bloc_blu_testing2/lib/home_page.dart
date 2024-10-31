import 'package:bloc_blu_testing2/model/github_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bl/home/home_page_imp.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageCubit get cubit => context.read<HomePageCubit>();

  @override
  void initState() {
    super.initState();
    cubit.fetchData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Minha app bar'),
        ),
        body: const BluImpWidget(),
      );
}

class BluImpWidget extends StatelessWidget {
  const BluImpWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.users.isEmpty) {
            return const Text('Erro ao obter usuários');
          } else if (state.users.isNotEmpty) {
            final users = state.users;

            return ListView.separated(
              itemBuilder: (context, index) {
                final user = users.elementAt(index);
                return ListTile(
                  title: Text(user.login),
                  leading: Image.network(user.avatarUrl),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.length,
            );
          }
          return const SizedBox.shrink();
        },
        listener: (context, state) {
          if (state.errorType == HomePageErrorType.fetchData) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Erro ao obter dados'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          }
        },
      );
}

class SuccessWidget extends StatelessWidget {
  final List<GithubUser> users;

  const SuccessWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final user = users.elementAt(index);
        return ListTile(
          title: Text(user.login),
          leading: Image.network(user.avatarUrl),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }
}
