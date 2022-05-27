import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/friend_repository.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/routes/routes.dart';

class FriendController extends GetxController {
  late UserModel userModel = UserModel();
  List<UserModel> listFriends = [];
  bool isLoadingFriend = true;
  @override
  void onInit() async {
    AuthController authController = Get.find();
    userModel = authController.userModel!;
    listFriends = (await StorageHelper.getFriends());
    update();
    FriendRepository.getFriends(userId: userModel.id!).then((value) {
      Function compare = const ListEquality().equals;

      if (!compare(value, listFriends)) {
        listFriends = value;
        StorageHelper.setFriends(value);
        isLoadingFriend = false;
        update();
      }
    });

    super.onInit();
  }

  startAddNewFriend() {
    Get.toNamed(Routes.ADD_FRIEND_SCREEN, arguments: {'user-model': userModel});
  }
}
