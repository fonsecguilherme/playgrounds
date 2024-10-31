// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const AuthScreen());

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const MaterialApp(
        home: Scaffold(
          body: Center(child: AuthScreenBody()),
        ),
      ),
    );
  }
}

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStatus>(
      builder: (context, state) {
        if (state == AuthStatus.loading) {
          return const CircularProgressIndicator();
        } else if (state == AuthStatus.authenticated) {
          return const Text('Usuário autenticado!');
        } else {
          return ElevatedButton(
            onPressed: () {
              // Chama o método para autenticar
              context.read<AuthCubit>().authenticate();
            },
            child: const Text('Autenticar'),
          );
        }
      },
    );
  }
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
}

class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.initial);

  void authenticate() async {
    emit(AuthStatus.loading);

    // Simula um processo assíncrono, como uma requisição de login
    await Future.delayed(const Duration(seconds: 2));

    // Supondo que a autenticação seja bem-sucedida
    emit(AuthStatus.authenticated);
  }
}
