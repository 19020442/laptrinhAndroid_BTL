import 'dart:convert';

import 'package:no_name_app/models/user_model.dart';

class AuthModel {
  UserModel? userModel;

  String? accessToken;
  AuthModel({
    this.userModel,
    this.accessToken,
  });
  Map<String, dynamic> toMap() {
    return {
      'userModel': userModel?.toMap(),
      'accessToken': accessToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      userModel:
          map['userModel'] != null ? UserModel.fromMap(map['userModel']) : null,
      accessToken: map['accessToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));
}
