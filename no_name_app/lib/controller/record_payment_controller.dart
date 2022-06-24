import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/user_repo.dart';

class RecordPaymentController extends GetxController {
  late Map<String, dynamic> payer;
  late GroupModel currentGroup;
  late UserModel owner;
  TextEditingController valueController =  TextEditingController();
  late FocusNode valueFocus;
  @override
  void onInit() {
    payer = Get.arguments['payer'];
    UserRepository.getAvatarUserById(id: payer['id']).then((value) {
      payer['avatar'] = value;
      update();
    });
    currentGroup = Get.arguments['group-model'];
    AuthController _authController = Get.find();
    owner = _authController.userModel!;
    valueFocus = FocusNode();
    valueFocus.requestFocus();
    valueController.text = '${payer['amount'].toInt()}';

    // owner = Get.arguments['owner'];
    super.onInit();
  }

  onSave() {
    // ExpenseRepository.getIdOfExpenseInGroup(groupId: groupId)
    ExpenseRepository.getIdOfExpenseInGroup(groupId: currentGroup.id!)
        .then((value) {
      final newExpense = ExpenseModel(
        note: '',
        id: value,
        name:
            '${payer['name']} đã đưa ${owner.name} ${valueController.text} vnđ',
        dateCreate: DateTime.now(),
        value: valueController.text,
        members: [],
        type: 'record',
        category: ''
      );
      final payerDataUser = UserModel(
        id: payer['id'],
        name: payer['name'],
      );

      ExpenseRepository.setExpenseOnGroupCollection(
              groupId: currentGroup.id!, expenseModel: newExpense)
          .whenComplete(() async {
        await ExpenseRepository.setPayerAndOwnerOfExpense(
            groupId: currentGroup.id!,
            expenseId: value,
            payersData: [
              {
                'user': payerDataUser,
                'amount': valueController.text,
                'owner': [
                  {
                    'user': owner,
                    'amount': valueController.text,
                  }
                ],
              }
            ],
            ownersData: [
              {
                'user': owner,
                'amount': int.parse(valueController.text),
                'payer': [
                  {
                    'user': payerDataUser,
                    'amount': int.parse(valueController.text),
                  }
                ]
              }
            ]);
        await GroupRepository.setStatusGroup(
            groupId: currentGroup.id!,
            data: [
              {
                'user': payerDataUser,
                'amount': int.parse(valueController.text),
                'owner': [
                  {
                    'user': owner,
                    'amount': int.parse(valueController.text),
                  }
                ],
              }
            ],
            isPayer: true);
        await GroupRepository.setStatusGroup(
            groupId: currentGroup.id!,
            data: [
              {
                'user': owner,
                'amount': int.parse(valueController.text),
                'payer': [
                  {
                    'user': payerDataUser,
                    'amount': int.parse(valueController.text)
                  }
                ]
              }
            ],
            isPayer: false);
        GroupController groupsController = Get.find();
        groupsController.onInit();
        Get.back();
        Get.back();
      });
    });
  }
}
