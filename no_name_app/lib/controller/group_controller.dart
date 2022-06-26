import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/storage_helper.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/group/create_new_group_screen.dart';

class GroupController extends GetxController {
  late UserModel userModel;
  List<Map<GroupModel, double>> listGroups = [];
  bool isShowFilterTable = false;
  Map<String, bool> filterTable = {
    'all': true,
    'own': false,
    'owned': false,
  };
  String yourOverral = '';

  bool isLoadingGroup = true;

  double totalOvrOnGroup = 0;

  late Stream groupsListener;
  @override
  void onInit() async {
    totalOvrOnGroup = 0;
    groupsListener =
        FirebaseFirestore.instance.collection('groups').snapshots();
    AuthController _authController = Get.find();
    userModel = _authController.userModel!;
    // listGroups = (await StorageHelper.getGroups());

    // update();
    UserRepository.getGroups(uid: userModel.id!).then((value) async {
      List<Map<GroupModel, double>> temp = [];

      if (value == null) {
        listGroups = [];
        isLoadingGroup = false;
        update();
      } else {
        for (int i = 0; i < value.length; i++) {
          GroupRepository.getStatusGroupByUserId(
              groupId: value[i], userId: userModel.id!);
          final groupData =
              await GroupRepository.getGroupbyId(idGroup: value[i]);
          final groupOvr = await GroupRepository.getOverralStatusOfGroup(
              gid: value[i], uid: userModel.id!);
          totalOvrOnGroup += groupOvr;
          temp.add({groupData: groupOvr});
        }
        listGroups = temp;
        isLoadingGroup = false;
        update();
      }
    });
    super.onInit();
  }

  // listen() {
  //   groupsListener.listen((event) {
  //     UserRepository.getGroups(uid: userModel.id!).then((value) async {
  //       List<Map<GroupModel, double>> temp = [];

  //       if (value == null) {
  //         listGroups = [];
  //         isLoadingGroup = false;
  //         update();
  //       } else {
  //         for (int i = 0; i < value.length; i++) {
  //           GroupRepository.getStatusGroupByUserId(
  //               groupId: value[i], userId: userModel.id!);
  //           final groupData =
  //               await GroupRepository.getGroupbyId(idGroup: value[i]);
  //           final groupOvr = await GroupRepository.getOverralStatusOfGroup(
  //               gid: value[i], uid: userModel.id!);
  //           totalOvrOnGroup += groupOvr;
  //           temp.add({groupData: groupOvr});
  //         }
  //         listGroups = temp;
  //         isLoadingGroup = false;
  //         update();
  //       }
  //     });
  //   });
  // }

  void startCreateNewGroup() {
    Get.bottomSheet(
      CreateNewGroupScreen(),

      // isScrollControlled: true
    );
    // Get.toNamed(Routes.CREATE_NEW_GROUP);
  }

  void openFilterTable() {
    isShowFilterTable = !isShowFilterTable;
    update();
  }

  onSelectFilter(String type) {
    filterTable[type] = true;
    if (type == 'all') {
      filterTable['own'] = false;
      filterTable['owned'] = false;
    } else if (type == 'own') {
      filterTable['all'] = false;
      filterTable['owned'] = false;
    } else {
      filterTable['all'] = false;
      filterTable['own'] = false;
    }
    update();
  }
}
