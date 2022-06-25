import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/friend_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/routes/routes.dart';

class FriendController extends GetxController {
  late UserModel userModel = UserModel();
  late List<Map<UserModel, dynamic>> listFriends = [];
  bool isLoadingFriend = true;

  late Stream friendListener;
  @override
  void onInit() async {
    AuthController authController = Get.find();
    userModel = authController.userModel!;
    friendListener = FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id!)
        .collection('friends')
        .snapshots();

    listenOnFriend();
    super.onInit();
  }

  listenOnFriend() async {
    friendListener.listen((event) {
      FriendRepository.getFriends(userId: userModel.id!).then((value) async {
        // Function compare = const ListEquality().equals;
        for (int i = 0; i < value.length; i++) {
          final sts = await FriendRepository.getYourStatusOnFriend(
              userId: userModel.id!, friendId: value[i].id!);
          listFriends.add({value[i]: sts});
        }
        StorageHelper.setFriends(value);
        // update();
      }).then((_) {
        isLoadingFriend = false;

        update();
      });
    });
  }

  startAddNewFriend() {
    Get.toNamed(Routes.ADD_FRIEND_SCREEN, arguments: {'user-model': userModel});
  }
}
