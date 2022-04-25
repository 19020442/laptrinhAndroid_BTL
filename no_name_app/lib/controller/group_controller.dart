import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';

class GroupController extends GetxController {
  late UserModel userModel;
  List<GroupModel> listGroups = [];
  @override
  void onInit() async {
    AuthController _authController = Get.find();
    userModel = _authController.userModel!;
    listGroups = (await StorageHelper.getGroups())!;

    update();
    UserRepository.getGroups(uid: userModel.id!).then((value) async {
      List<GroupModel> temp = [];
      Function compare = const ListEquality().equals;

      if (value == null) {
        listGroups = [];
        update();
      } else {
        for (int i = 0; i < value.length; i++) {
          final groupData =
              await GroupRepository.getGroupbyId(idGroup: value[i]);
          temp.add(groupData);
        }

        if (!compare(listGroups, temp)) {
          listGroups = temp;
          StorageHelper.setGroup(temp); 
          update();
        }
        // userModel.ownGroups = temp;

        // update();
      }
    });

    super.onInit();
  }

  void startCreateNewGroup() {
    Get.toNamed(Routes.CREATE_NEW_GROUP);
  }
}
