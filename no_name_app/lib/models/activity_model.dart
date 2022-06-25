import 'dart:convert';

import 'package:no_name_app/models/user_model.dart';

enum TypeOfActivity {
  CreateNewGroup,
  CommentOnExpense,
  DeleteGroup,
  LeaveGroup,
  AddNewFriend,
  UpdateNote,
  AddIntoGroup,
  AddNewExpense,
}

class ActivityModel {
  String? id;
  DateTime? timeCreate;
  TypeOfActivity? type;
  UserModel? actor; // người dùng thực hiện
  dynamic useCase; // là đối tượng tác động, thêm hóa đơn -> use case hóa đơn
  dynamic zone; // xảy ra trong môi trường nào? thêm hóa đơn thì trong zone group nào
  ActivityModel(
      {this.id,
      this.timeCreate,
      this.type,
      this.actor,
      this.useCase,
      this.zone});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': timeCreate,
      'type': type.toString(),
      'actor': actor?.toMap(),
      'case': useCase == null ? '' : useCase.toMap(),
      'zone': zone == null ? '' : zone.toMap()
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
        id: map['id'],
        timeCreate: map['time'],
        type: map['type'],
        actor: map['actor'],
        useCase: map['case'],
        zone: map['zone']);
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) =>
      ActivityModel.fromMap(json.decode(source));
}
