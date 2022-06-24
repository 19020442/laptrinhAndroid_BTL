import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/storage_helper.dart';

import 'package:no_name_app/routes/routes.dart';

class AccountController extends GetxController {
  late UserModel userModel;
  final AuthController _authController = Get.find();

  @override
  void onInit() {
    userModel = _authController.userModel!;

    super.onInit();
  }

  logOut() {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    _googleSignIn.signOut();
    StorageHelper.setFriends(null);
    StorageHelper.setGroup(null);
    FirebaseAuth.instance.signOut();
    AuthController _authController = Get.find();
    _authController.setUser(null);
    Get.offAndToNamed(Routes.LOGIN_SCREEN);
    update();
  }
}
