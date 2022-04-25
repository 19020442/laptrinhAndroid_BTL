import 'dart:convert';

import 'package:no_name_app/models/group_model.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  // List<GroupModel>? ownGroups;
  UserModel({this.id, this.name, this.email});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      // ownGroups: map['groups']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
