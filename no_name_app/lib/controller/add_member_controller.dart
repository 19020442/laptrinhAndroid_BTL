import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/controller/my_group_controller.dart';

import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class AddMemberController extends GetxController {
  List<UserModel> friendsAreChosen = [];

  List<UserModel> yourFriends = [];

  List<UserModel> listMember = [];

  late UserModel userModel;

  late GroupModel currentGroup;
  onClickFriend(UserModel friend) {
    friendsAreChosen.add(friend);
    update();
  }

  onSave() async {
    Get.dialog(const LoadingWidget());
    await GroupRepository.addMember(host: userModel,
        group: currentGroup, listMemberAdd: friendsAreChosen, );
    MyGroupController myGroupController = Get.find();
    myGroupController.addMember(friendsAreChosen);

    Get.back();
    Get.back();
  }

  bool isJoined(UserModel fr) {
    return listMember.indexWhere((e) => e.id == fr.id) != -1;
  }

  @override
  void onInit() async {
    AuthController _authController = Get.find();  
    userModel = _authController.userModel!;
    currentGroup = Get.arguments['group-model'];
    yourFriends = await StorageHelper.getFriends();
    listMember = Get.arguments['list-member'];
    update();
    super.onInit();
  }
}
