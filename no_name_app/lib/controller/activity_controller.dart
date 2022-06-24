import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/activity_repository.dart';

class ActivityController extends GetxController {
  late UserModel userModel;
  final AuthController _authController = Get.find();
  List<ActivityModel> listActivity = [];
  @override
  void onInit() {
    userModel = _authController.userModel!;
    ActivityRepository.getActivities(actor: userModel).then((value) {
      listActivity = value;
      // print(listActivity.elementAt(0));
      update();
    });
    super.onInit();
  }
}
