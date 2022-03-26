import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_name_app/controller/account_controller.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/account_screen.dart';
import 'package:no_name_app/screens/friends_screen.dart';
import 'package:no_name_app/screens/groups_screen.dart';
import 'package:no_name_app/screens/activities_screen.dart';

class HomeController extends GetxController {
  late UserModel userModel;
  int currentIndex = 0;
  var listPages = [
    GroupScreen(),
    FriendScreen(),
    ActivitiesScreen(),
    AccountScreen()
  ];
  @override
  void onInit() {
    AuthController _authController = Get.find();
    print('----' + _authController.userModel.toString());
    // AccountController a = Get.find();
    // a.logOut();
    // userModel = Get.arguments['user_model'];
    super.onInit();
  }

  void updateIndex(int value) {
    currentIndex = value;
    update();
  }
}
