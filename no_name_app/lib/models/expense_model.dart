import 'dart:convert';

import 'package:no_name_app/models/user_model.dart';

class ExpenseModel {
  String id;
  String name;
  DateTime dateCreate;
  String value;
  List<UserModel> members;
  String note;
  String type;
  String category;

  ExpenseModel({
    required this.id,
    required this.name,
    required this.dateCreate,
    required this.value,
    required this.members,
    required this.note,
    required this.type,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {'Id': id, 'Name': name, 'Datetime': dateCreate, 'Value': value, 'Note': note, 'Type' : type,'Category' :category};
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['Id'],
      name: map['Name'],
      dateCreate: map['Datetime'],
      value: map['Value'],
      members: map['Members'],
      note: map['Note'],
      type: map['Type'],
      category: map['Category']
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));
}
