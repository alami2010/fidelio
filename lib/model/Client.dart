import 'History.dart';

class Client {
  int id;
  int solde;
  String email;
  String name;
  String code;
  List<int> amounts =[];
  List<String> fastFoodRepas;
  List<String> pizza;
  List<String> coiffeur;

  List<History> history =[];

  Client({this.id, this.solde, this.email, this.name, this.code,this.amounts, this.history});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    solde = json['solde'];
    email = json['email'];
    name = json['name'];
    code = json['code'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    amounts = json['amounts'].cast<int>();
    fastFoodRepas = json['fastFoodRepas'].cast<String>();
    pizza = json['pizza'].cast<String>();
    coiffeur = json['coiffeur'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['solde'] = this.solde;
    data['email'] = this.email;
    data['name'] = this.name;
    data['code'] = this.code;
    data['amounts'] = this.amounts;
    data['fastFoodRepas'] = this.fastFoodRepas;
    data['pizza'] = this.pizza;
    data['coiffeur'] = this.coiffeur;


    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Client{id: $id, solde: $solde, email: $email, name: $name, code: $code, amounts: $amounts, history: $history}';
  }
}