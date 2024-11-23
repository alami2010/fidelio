import 'dart:async';
import 'dart:convert';

import 'package:fidelway/model/Client.dart';
import 'package:http/http.dart' as http;

const isLocal = false;
const baseUrl =
    isLocal ? "http://localhost:8080/api/" : "https://dinapolipizzacarrieres.fr/api/api/";

Map<String, String> buildHeader() {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

class APIRest {
  static Future<Client> scan(String code) async {
    var url = baseUrl + 'fidel-way-client/' + code;
    print(url);

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
      print(code);
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors de get scan');
    }
  }

  static Future<Client> create(String code, String name, String tel) async {
    var url = baseUrl + 'fidel-way-client/';

    Map data = {
      'email': tel,
      'name': name,
      'code': code,
      'solde': 0,
    };

    final response = await http.post(Uri.parse(url),
        body: json.encode(data), headers: buildHeader());
    if (response.statusCode == 201) {
      return Client.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors create carte');
    }
  }

  static Future<Client> minus(String code, int points) async {
    var url = baseUrl + 'fidel-way-client/' + code + '/' + points.toString();

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors de get agency');
    }
  }
}
