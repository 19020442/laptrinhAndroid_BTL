import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_name_app/models/user_model.dart';

class GroupModel {
  String? id;
  String? imageGroup;
  String? nameGroup;
  String? typeGroup;
  List<UserModel>? members;

  GroupModel(
      {this.id, this.nameGroup, this.imageGroup, this.typeGroup, this.members});

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Image': imageGroup,
      'Name': nameGroup,
      'Type': typeGroup,
      'Members': members
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
        id: map['Id'],
        imageGroup: map['Image'],
        nameGroup: map['Name'],
        typeGroup: map['Type'],
        members: map['Members']);
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source));
}
