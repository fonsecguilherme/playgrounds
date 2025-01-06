import 'package:estados_municipios/estados_municipios.dart';

class EstadosController {
  final controller = EstadosMunicipiosController();
  List<String> newList = [];

  Future<List<String>> getEstados() async {
    final estados = await controller.buscaTodosEstados();

    for (var estado in estados) {
      newList.add("${estado.nome} - ${estado.sigla}");
    }

    return newList;
  }
}
