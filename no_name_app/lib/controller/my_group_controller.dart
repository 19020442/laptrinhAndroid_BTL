import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/controller/home_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class MyGroupController extends GetxController {
  GroupModel currentGroup = GroupModel();
  late UserModel userModel;
  List<ExpenseModel> listExpenses = [];
  List<UserModel> listMember = [];
  List<Map<String, dynamic>> status = [];
  List<double> listState = [];
  bool isLoading = true;
  
  
  @override
  void onInit() {
    currentGroup = Get.arguments['group-model'];
   
    userModel = Get.arguments['user-model'];
    ExpenseRepository.getExpenses(groupId: currentGroup.id!).then((value) {
      listExpenses = value;
      for (int i = 0; i < listExpenses.length; i++) {
        listState.add(0);
      }
      update();
    }).then((_) {
      for (int i = 0; i < listExpenses.length; i++) {
        ExpenseRepository.getYourStatusOnExpense(
                currentExpense: listExpenses[i],
                groupId: currentGroup.id!,
                userId: userModel.id!)
            .then((value) {
          listState[i] = value;
          update();
        });
      }
      isLoading = false;
      update();
    });

    GroupRepository.getMemebers(groupId: currentGroup.id!).then((value) {
      listMember = value;
     listMember.forEach((e) {
        print(e.name);
     });
      
      update();
    });
    GroupRepository.getStatusGroupByUserId(
            groupId: currentGroup.id!, userId: userModel.id!)
        .then((value) {
      status = value;
      print(value);
      update();
    });

    super.onInit();
  }

  deleteGroup() {
    Get.dialog(const LoadingWidget());

    GroupRepository.leaveGroup(uid: userModel.id!, gid: currentGroup.id!).then(
        (value) =>
            GroupRepository.removeGroup(gid: currentGroup.id!).then((value) {
              Get.back();
              GroupController groupController = Get.find();
              groupController.onInit();

              Get.back();
              Get.back();
            }));
  }

  leaveGroup() {
    Get.dialog(const LoadingWidget());

    GroupRepository.leaveGroup(uid: userModel.id!, gid: currentGroup.id!)
        .then((value) {
      Get.back();
      GroupController groupController = Get.find();
      groupController.onInit();

      Get.back();
      Get.back();
    });
  }

  addMember(List<UserModel> list) {
    listMember.addAll(list);
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
