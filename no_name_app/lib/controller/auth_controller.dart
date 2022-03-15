import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_name_app/models/auth_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';

class AuthController extends GetxController {
  bool isLogin = false;
  UserModel? userModel;

  @override
  void onInit() {
    checkUser();
    super.onInit();
  }

  checkUser() async {
   
    userModel = await StorageHelper.getAuth();
    if (userModel == null) {
      isLogin = false;
    } else {
      isLogin = true;
    }
  }

  setUser(UserModel? userModel) async {
    this.userModel = userModel;
    if (userModel == null) {
      isLogin = false;
    } else {
      UserModel? checkUser =
          await UserRepository.getUserByEmail(email: userModel.email!);
      if (checkUser != null) {
        isLogin = true;
      }
    }
    StorageHelper.setAuth(userModel);
  }


}
