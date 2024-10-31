import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/address_model.dart';

abstract interface class IViaCepRepository {
  Future<AddressModel?> fetchAddress({String zipCode});
}

class ViaCepRepository implements IViaCepRepository {
  @override
  Future<AddressModel?> fetchAddress({String zipCode = '57305752'}) async {
    final String url = 'https://viacep.com.br/ws/$zipCode/json/';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final address = jsonDecode(response.body);
      if (address['erro'] == null) {
        return AddressModel.fromJson(address);
      } else {
        throw Exception('Cep not found');
      }
    } else {
      throw Exception('Cep not found 2');
    }
  }
}
