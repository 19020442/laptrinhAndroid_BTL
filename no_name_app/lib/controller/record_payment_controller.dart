import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';

class RecordPaymentController extends GetxController {
  late Map<String, dynamic> payer;
  late GroupModel currentGroup;
  late UserModel owner;
  TextEditingController valueController = new TextEditingController();
  late FocusNode valueFocus;
  @override
  void onInit() {
    payer = Get.arguments['payer'];
    currentGroup = Get.arguments['group-model'];
    AuthController _authController = Get.find();
    owner = _authController.userModel!;
    valueFocus = FocusNode();
    valueFocus.requestFocus();
    valueController.text = '${payer['amount']}';

    // owner = Get.arguments['owner'];
    super.onInit();
  }

  onSave() {
    // ExpenseRepository.getIdOfExpenseInGroup(groupId: groupId)
    ExpenseRepository.getIdOfExpenseInGroup(groupId: currentGroup.id!)
        .then((value) {
      final newExpense = ExpenseModel(
          id: value,
          name: '${payer['name']} paid ${owner.name} ${valueController.text}',
          dateCreate: DateTime.now(),
          value: valueController.text,
          members: []);
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
                'amount': double.parse(valueController.text),
                'payer': [
                  {
                    'user': payerDataUser,
                    'amount': double.parse(valueController.text),
                  }
                ]
              }
            ]);
        await GroupRepository.setStatusGroup(
            groupId: currentGroup.id!,
            data: [
              {
                'user': payerDataUser,
                'amount': double.parse(valueController.text),
                'owner': [
                  {
                    'user': owner,
                    'amount': double.parse(valueController.text),
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
                'amount': double.parse(valueController.text),
                'payer': [{
                  'user':payerDataUser,
                  'amount': double.parse(valueController.text)
                }]
              }
            ],
            isPayer: false);
        // MyGroupController groupController = Get.find();
        // groupController.onInit();
        Get.back();
        Get.back();
      });
    });
  }
}
