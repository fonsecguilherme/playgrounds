import 'dart:developer';

import 'package:bloc_heritage/select_page/counter.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutDoisWidget();
  }
}

class LayoutDoisWidget extends StatelessWidget {
  const LayoutDoisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var counter1 = 0;
    var counter2 = 0;
    var counter3 = 0;

    final stopWatchBlocBuilder = Stopwatch();
    final stopWatchBlocSelector = Stopwatch();
    final stopWatchContextSelect = Stopwatch();

    return Scaffold(
      appBar: AppBar(title: const Text('Selector text')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  'Valor atual: $state',
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            Divider(),
            const Text('BlocBuilder'),
            //USANDO O BUILDER MESMO O VALOR NÃO SENDO MULTIPLO DE 5
            // O log DO BUILDER SEMPRE É CHAMADO
            //OU SEJA, ESTÁ FAZENDO REBUILDS DESNECESSÁRIOS
            BlocBuilder<CounterCubit, int>(
              //TODO: usar também o buildwhen pra ver se fica com comportamento parecido com o selector
              builder: (context, state) {
                late final Widget widget;
                stopWatchBlocBuilder.reset();

                stopWatchBlocBuilder.start();

                log('1️⃣ BlocBuilder chamado com valor: $state');

                if (state == 0) {
                  widget = const Center(
                    child: Text('O valor é 0 → não é múltiplo de ninguém'),
                  );
                } else {
                  final isMultiple = state % 5 == 0;
                  widget = Center(
                    child: isMultiple
                        ? Text('$isMultiple → O valor é múltiplo de 5')
                        : const Text('Não é múltiplo de 5'),
                  );
                }

                stopWatchBlocBuilder.stop();

                log('1️⃣ O acumulado do BlocBuilder é de $counter1 µs');
                log(
                  '1️⃣ Esse rebuild BlocBuilder durou: ${stopWatchBlocBuilder.elapsedMicroseconds} µs',
                );

                counter1 += stopWatchBlocBuilder.elapsedMicroseconds;
                log(
                  '1️⃣ Acumulado de todos os rebuilds do BlocBuilder é: $counter1 µs',
                );
                log(
                  '------------------------------------------------------------------------\n',
                );

                return widget;
              },
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
            BlocSelector<CounterCubit, int, (int, bool)>(
              selector: (state) {
                final isMultipleOrZero = state == 0 || state % 5 == 0;
                return (state, isMultipleOrZero);
              },
              builder: (context, record) {
                final (state, isMultipleOrZero) = record;

                stopWatchBlocSelector
                  ..reset()
                  ..start();

                String message;
                if (state == 0) {
                  message = 'O valor é 0 → não é múltiplo de ninguém';
                } else if (isMultipleOrZero) {
                  message = '$state é múltiplo de 5';
                } else {
                  message = '$state não é múltiplo de 5';
                }

                stopWatchBlocSelector.stop();

                log(
                  '2️⃣ Esse rebuild do BlocSelector durou: '
                  '${stopWatchBlocSelector.elapsedMicroseconds} µs',
                );

                counter2 += stopWatchBlocSelector.elapsedMicroseconds;

                log(
                  '2️⃣ Acumulado de todos os rebuilds do BlocSelector: $counter2 µs',
                );
                log(
                  '------------------------------------------------------------------------\n',
                );

                return Center(child: Text(message));
              },
            ),

            Divider(),
            const Text('context.select'),
            Builder(
              builder: (context) {
                stopWatchContextSelect
                  ..reset()
                  ..start();

                final (state, isMultipleOrZero) = context
                    .select<CounterCubit, (int, bool)>((cubit) {
                      final s = cubit.state;
                      return (s, s == 0 || s % 5 == 0);
                    });

                stopWatchContextSelect.stop();

                log(
                  '3️⃣ Esse rebuild context.select durou: '
                  '${stopWatchContextSelect.elapsedMicroseconds} µs',
                );

                counter3 += stopWatchContextSelect.elapsedMicroseconds;

                log(
                  '3️⃣ Acumulado de todos os rebuilds context.select: $counter3 µs',
                );
                log(
                  '-------------------------------------------------------------\n',
                );

                return Center(
                  child: Text(
                    state == 0
                        ? 'O valor é 0 → não é múltiplo de ninguém'
                        : isMultipleOrZero
                        ? '$state é múltiplo de 5'
                        : '$state não é múltiplo de 5',
                  ),
                );
              },
            ),

            Divider(),
            Row(
              mainAxisSize: .max,
              mainAxisAlignment: .center,
              children: <Widget>[
                IconButton.filled(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton.filled(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutUmWidget extends StatelessWidget {
  const LayoutUmWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: (context, value) {
              return Text(
                'Valor atual: $value',
                style: const TextStyle(fontSize: 20),
              );
            },
          ),
        ),
        const Text('BlocBuilder'),
        BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            log('BlocBuilder rebuildado');
            log('--------------------------------------------------------');

            final isMultiple = state % 5 == 0;

            return Center(
              child: isMultiple
                  ? Text('$isMultiple → O valor é múltiplo de 5')
                  : const Text('Não é múltiplo de 5'),
            );
          },
        ),
        Divider(),
        const Text('BlocSelector'),
        BlocSelector<CounterCubit, int, bool>(
          selector: (state) {
            return state % 5 == 0;
          },
          builder: (context, isMultiple) {
            log('SELECTOR rebuildado');
            log('--------------------------------------------------------');
            return Center(
              child: isMultiple
                  ? Text('$isMultiple → O valor é múltiplo de 5')
                  : const Text('Não é múltiplo de 5'),
            );
          },
        ),
        Divider(),
        const Text('context.select'),
        Builder(
          builder: (context) {
            log('context.select rebuildado');
            log('--------------------------------------------------------');

            final isMultiple = context.select<CounterCubit, bool>((cubit) {
              final state = cubit.state;
              return state == 0 || state % 5 == 0;
            });

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
              icon: const Icon(Icons.remove),
            ),
            IconButton.filled(
              onPressed: () {
                context.read<CounterCubit>().increment();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    ),
  );
}


/*
class LayoutDoisWidget extends StatelessWidget {
  const LayoutDoisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var counter1 = 0;
    var counter2 = 0;
    var counter3 = 0;

    final stopWatchBlocBuilder = Stopwatch();
    final stopWatchBlocSelector = Stopwatch();
    final stopWatchContextSelect = Stopwatch();

    return Scaffold(
      appBar: AppBar(title: const Text('Selector text')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  'Valor atual: $state',
                  style: const TextStyle(fontSize: 20),
                );
              },
            ),
            Divider(),
            const Text('BlocBuilder'),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                late final Widget widget;

                stopWatchBlocBuilder.start();

                log('1️⃣ BlocBuilder chamado com valor: $state');

                if (state == 0) {
                  widget = const Center(
                    child: Text('O valor é 0 → não é múltiplo de ninguém'),
                  );
                } else {
                  final isMultiple = state % 5 == 0;
                  widget = Center(
                    child: isMultiple
                        ? Text('$isMultiple → O valor é múltiplo de 5')
                        : const Text('Não é múltiplo de 5'),
                  );
                }

                stopWatchBlocBuilder.stop();

                log('1️⃣ O acumulado do BlocBuilder é de $counter1 µs');
                log(
                  '1️⃣ Esse rebuild BlocBuilder durou: ${stopWatchBlocBuilder.elapsedMicroseconds} µs',
                );

                counter1 += stopWatchBlocBuilder.elapsedMicroseconds;
                log(
                  '1️⃣ Acumulado de todos os rebuilds do BlocBuilder é: $counter1 µs',
                );
                log(
                  '------------------------------------------------------------------------\n',
                );

                return widget;
              },
            ),

            Divider(),
            const Text('BlocSelector'),
            BlocSelector<CounterCubit, int, (int, bool)>(
              selector: (state) {
                final isMultipleOrZero = state == 0 || state % 5 == 0;

                log('2️⃣ SELECTOR chamado com valor: $state');

                return (state, isMultipleOrZero);
              },
              builder: (context, record) {
                final (state, isMultipleOrZero) = record;

                stopWatchBlocSelector.start();

                String message;
                if (state == 0) {
                  message = 'O valor é 0 → não é múltiplo de ninguém';
                } else if (isMultipleOrZero) {
                  message = '$state é múltiplo de 5';
                } else {
                  message = '$state não é múltiplo de 5';
                }

                stopWatchBlocSelector.stop();

                log(
                  '2️⃣ Esse rebuild do BlocSelector durou: ${stopWatchBlocSelector.elapsedMicroseconds} µs',
                );

                counter2 += stopWatchBlocSelector.elapsedMicroseconds;

                log(
                  '2️⃣ Acumulado de todos os rebuilds do BlocSelector: $counter2 µs',
                );
                log(
                  '------------------------------------------------------------------------\n',
                );

                return Center(child: Text(message));
              },
            ),

            Divider(),
            const Text('context.select'),
            Builder(
              builder: (context) {
                stopWatchContextSelect.start();
                final (state, isMultipleOrZero) = context
                    .select<CounterCubit, (int, bool)>((cubit) {
                      final s = cubit.state;
                      return (s, s == 0 || s % 5 == 0);
                    });

                stopWatchContextSelect.stop();

                log('3️⃣ context.select chamado com valor de state: $state');

                String message;
                if (state == 0) {
                  message = 'O valor é 0 → não é múltiplo de ninguém';
                } else if (isMultipleOrZero) {
                  message = '$state é múltiplo de 5';
                } else {
                  message = '$state não é múltiplo de 5';
                }

                log(
                  '3️⃣ Esse rebuild context.select durou: ${stopWatchContextSelect.elapsedMicroseconds} µs',
                );

                counter3 += stopWatchContextSelect.elapsedMicroseconds;

                log(
                  '3️⃣ Acumulado de todos os rebuilds context.select: $counter3 µs',
                );
                log(
                  '-------------------------------------------------------------\n',
                );

                return Center(child: Text(message));
              },
            ),

            Divider(),
            Row(
              mainAxisSize: .max,
              mainAxisAlignment: .center,
              children: <Widget>[
                IconButton.filled(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  icon: const Icon(Icons.remove),
                ),
                IconButton.filled(
                  onPressed: () {
                    context.read<17131CounterCubit>().increment();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/