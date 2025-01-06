import 'package:flutter/material.dart';
import 'package:teste_estados_br/controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final meuController = EstadosController();
  List<String> myList = []; // Lista inicial vazia

  @override
  void initState() {
    super.initState();
    _loadEstados();
  }

  Future<void> _loadEstados() async {
    final estados = await meuController.getEstados();
    setState(() {
      myList = estados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: myList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  myList.length,
                  (index) {
                    return Text(myList[index]);
                  },
                ),
              ),
      ),
    );
  }
}
