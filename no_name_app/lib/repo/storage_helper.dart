import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:no_name_app/models/auth_model.dart';
import 'package:no_name_app/models/user_model.dart';

class StorageHelper {
  static GetStorage box = GetStorage();

  static const String KEY_AUTH = 'auth';

  static Future<UserModel?> getAuth() async {
    final result = await box.read(KEY_AUTH);  
    if (result != null) {
      return UserModel.fromJson(result);
    }
    return null;
  }

  static Future<void> setAuth(UserModel? userModel) async {
    if (userModel == null) {
      await box.write(KEY_AUTH, null);
    } else {
      await box.write(KEY_AUTH, userModel.toJson());
    }
  }


}
