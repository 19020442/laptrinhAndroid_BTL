import 'dart:convert';

import 'package:no_name_app/models/user_model.dart';

enum TypeOfActivity { CreateNewGroup, CommentOnExpense, DeleteGroup, LeaveGroup, AddNewFriend }

class ActivityModel {
  String? id;
  DateTime? timeCreate;
  TypeOfActivity? type;
  UserModel? actor;
  dynamic useCase;
  dynamic zone;
  ActivityModel({this.id, this.timeCreate, this.type, this.actor, this.useCase, this.zone});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': timeCreate,
      'type': type.toString(),
      'actor': actor?.toMap(),
      'case':useCase == null ? '' :useCase.toMap(),
      'zone': zone == null ? '': zone.toMap()
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
        id: map['id'],
        timeCreate: map['time'],
        type: map['type'],
        actor: map['actor'],
        useCase: map['case'],
        zone: map['zone']
        );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source));
}
