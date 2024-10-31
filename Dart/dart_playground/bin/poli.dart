void main() {
  // final worker = Worker();
  // worker.work();

  final manager = Manager();
  manager.work();

  final caixa = Caixa();
  caixa.work();
}

abstract class Worker {
  void work() {}
}

class Manager implements Worker {
  @override
  void work() {
    print('manda nos outros');
  }
}

class Caixa implements Worker {
  @override
  void work() {
    print('obedece');
  }
}
