import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';

class FriendDetailController extends GetxController {
  late UserModel friend ;
  late dynamic data;
  late UserModel user;
  @override
  void onInit() {
    friend = Get.arguments['user-model'];
    data = Get.arguments['detail'];
    AuthController authController = Get.find();
    
    user = authController.userModel!;
    // TODO: implement onInit
    super.onInit();
  }
}