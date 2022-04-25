import 'package:get/get.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';

class MyGroupController extends GetxController {
  GroupModel currentGroup = GroupModel();
  late UserModel userModel;
  List<ExpenseModel> listExpenses = [];
  List<UserModel> listMember = [];
  List<Map<String, dynamic>> status = [];
  @override
  void onInit() {
    currentGroup = Get.arguments['group-model'];
    userModel = Get.arguments['user-model'];
    ExpenseRepository.getExpenses(groupId: currentGroup.id!).then((value) {
      listExpenses = value;
      update();
    });
    GroupRepository.getMemebers(groupId: currentGroup.id!).then((value) {
      listMember = value;
      update();
    });
    GroupRepository.getStatusGroupByUserId(
            groupId: currentGroup.id!, userId: userModel.id!)
        .then((value) {
      status = value;
      update();
    });
    super.onInit();
  }
}
