import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';

class StorageHelper {
  static GetStorage box = GetStorage();

  static const String KEY_AUTH = 'auth';
  static const String KEY_FRIENDS = 'friends';
  static const String KEY_GROUPS = 'groups';
  static Future<UserModel?> getAuth() async {
    final result = await box.read(KEY_AUTH);
    if (result != null) {
      return UserModel.fromJson(result);
    }
    return null;
  }

  static Future<List<GroupModel>> getGroups() async {
    final result = await box.read(KEY_GROUPS);
  
    if (result != null) {
      List<GroupModel> dataGroups = [];
      final localGroupData = (json.decode(json.encode(result)).toList());
      localGroupData.forEach((value) {
        final convert = json.decode(value);
        GroupModel data = GroupModel(
          id: convert['Id'],
          imageGroup: convert['Image'],
          nameGroup: convert['Name'],
          typeGroup: convert['Type'],
        );
        List<UserModel> x = [];
        
        convert['Members'].toList().forEach((e) {
          x.add(UserModel.fromJson(e));
        });
        data.members = x;
      
        dataGroups.add(data);
      });
      return dataGroups;
    }
    return [];
  }

  static Future<List<UserModel>> getFriends() async {
    final result = await box.read(KEY_FRIENDS);
    if (result != null) {
      List<UserModel> data = [];
      final localFriendsData = (json.decode(json.encode(result)).toList());
      localFriendsData.forEach((value) {
        data.add(UserModel.fromJson(value));
      });
      return data;
    }
    return [];
  }

  static Future<void> setAuth(UserModel? userModel) async {
    if (userModel == null) {
      await box.write(KEY_AUTH, null);
    } else {
      await box.write(KEY_AUTH, userModel.toJson());
    }
  }

  static Future<void> setFriends(List<UserModel>? friends) async {
    await box.write(KEY_FRIENDS, friends);
  }

  static Future<void> setGroup(List<GroupModel>? groups) async {
    await box.write(KEY_GROUPS, groups);
  }
}
