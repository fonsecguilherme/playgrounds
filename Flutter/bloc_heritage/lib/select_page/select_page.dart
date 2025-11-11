import 'package:bloc_heritage/select_page/counter.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selector text'),
      ),
      body: SizedBox(
        // color: Colors.red,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('BlocBuilder'),
            //USANDO O BUILDER MESMO O VALOR NÃO SENDO MULTIPLO DE 5
            // O PRINT DO BUILDER SEMPRE É CHAMADO
            //OU SEJA, ESTÁ FAZENDO REBUILDS DESNECESSÁRIOS
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                print('BUILDER1 rebuildado com valor: $state');

                final isMultiple = state % 5 == 0;

                return Center(
                  child: isMultiple
                      ? Text('$isMultiple → O valor é múltiplo de 5')
                      : const Text('Não é múltiplo de 5'),
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    icon: const Icon(Icons.remove)),
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            Divider(),
            const Text('BlocSelector'),
            /*
            COM O SELECTOR A ALTERAÇÃO DO ESTADO SÓ ACONTECE QUANDO
            O VALOR RETORNADO É UM MULTIPLO DE 5 OU PRA SAIR DESSE VALOR MULTIPLO

            Aí pra usar o Selector, é preciso Cubit + state + retorno do selector que pode ser
            uma condicional que vai verificar se vai trigar o rebuild ou não

            Aí dentro do builder vamos usar esse condicional que vai fazer o rebuild ou não
            */
            BlocSelector<CounterCubit, int, bool>(
              selector: (state) {
                print('SELECTOR chamado com state: $state');

                return state % 5 == 0;
              },
              builder: (context, isMultiple) {
                print('BUILDER2 rebuildado com valor: $isMultiple');
                return Center(
                  child: isMultiple
                      ? Text('$isMultiple → O valor é múltiplo de 5')
                      : const Text('Não é múltiplo de 5'),
                );
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().decrement();
                    },
                    icon: const Icon(Icons.remove)),
                IconButton.filled(
                    onPressed: () {
                      context.read<CounterCubit>().increment();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),


            // FAzer usando context.select
          ],
        ),
      ),
    );
  }
}
