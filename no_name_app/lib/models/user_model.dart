import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? avatarImage;
  String? passCode;
  // List<GroupModel>? ownGroups;
  UserModel({this.id, this.name, this.email, this.avatarImage, this.passCode});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatarImage,
      'passcode': passCode
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        avatarImage: map['avatar'],
        passCode: map['passcode']
        // ownGroups: map['groups']
        );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
