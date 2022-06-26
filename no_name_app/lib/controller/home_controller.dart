
import 'package:get/get.dart';

import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';

import 'package:no_name_app/screens/account/account_screen.dart';
import 'package:no_name_app/screens/activity/activity_screen.dart';
import 'package:no_name_app/screens/friend/friends_screen.dart';
// import 'package:no_name_app/screens/friends_screen.dart';
import 'package:no_name_app/screens/group/groups_screen.dart';
// import 'package:no_name_app/screens/groups_screen.dart';

class HomeController extends GetxController {
  late UserModel userModel;
  int currentIndex = 0;
  var listPages = [
  const  GroupScreen(),
  const  FriendScreen(),
  const  ActivityScreen(),
  const  AccountScreen()
  ];
  @override
  void onInit() {
    AuthController _authController = Get.find();

    userModel = _authController.userModel!;

    super.onInit();
  }

  void updateIndex(int value) {
    currentIndex = value;
    update();
  }
}
