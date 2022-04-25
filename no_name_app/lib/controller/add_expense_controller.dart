import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';

class AddExpenseController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController amountPaidController = TextEditingController();
  late UserModel currentUser;
  GroupModel? groupModel;
  MyGroupController groupController = Get.find();
  List<UserModel> membersOfExpense = [];
  bool isMultiChoiceMode = false;
  List<Map<String, dynamic>> member = [];
  List<Map<String, dynamic>> payer = [];
  List<Map<String, dynamic>> owner = [];
  List<TextEditingController> amountPerPayer = [];
  List<Map<String, dynamic>> temp = [];
  final formKey = GlobalKey<FormState>();

  // slpit unqually var
  bool isOnSplitUnequallyMode = false;
  List<TextEditingController> percentMemberController = [];
  List<Map<String, dynamic>> percentOfExpense = [];
  double totalPercentCurrently = 0;
  final formKeySplitPercent = GlobalKey<FormState>();
  @override
  void onInit() {
    groupModel = Get.arguments['group-model'];
    currentUser = Get.arguments['user-model'];
    groupModel!.members = groupController.listMember;
    membersOfExpense = groupModel!.members!;
    amountPerPayer = List<TextEditingController>.filled(
        membersOfExpense.length, TextEditingController());

    for (int i = 0; i < membersOfExpense.length; i++) {
      member.add({});
      percentMemberController.add(TextEditingController());
    }

    update();
    super.onInit();
  }

  List<String> saveExpenseError() {
    List<String> errors = [];
    if (descriptionController.text == "") {
      errors.add('You must enter a description');
    }
    if (valueController.text == "") {
      errors.add('You must enter an amount');
    }

    return errors;
  }

  getTotalPercentCurrently() {
    double res = 0;
    for (int i = 0; i < percentMemberController.length; i++) {
      res += double.parse(percentMemberController[i].text.isEmpty
          ? "0"
          : percentMemberController[i].text);
    }
    totalPercentCurrently = res;
    update();
  }

  onSaveSetAmountPerMember(
      int index, UserModel membersOfExpense, String? value) {
    // if (!isOnSplitUnequallyMode) {
    if (value == "") {
      member[index] = {'user': membersOfExpense, 'amount': double.parse("0")};
    } else {
      member[index]['user'] = membersOfExpense;
      member[index]['amount'] = double.parse(value!);
    }

    update();
    if (index.isEqual(member.length - 1)) {
      Get.back();
    }
  }

  getNeedToPayEachMember() {
    if (totalPercentCurrently != 100.0) {
      Get.dialog(AlertDialog(
        title: const Text('ERROR'),
        content: const Text('Total percent must be 100'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'))
        ],
      ));
    } else {
      if (isOnSplitUnequallyMode) {
        for (int i = 0; i < member.length; i++) {
          member[i]['amountToPaid'] = double.parse(valueController.text) *
              double.parse(percentMemberController[i].text);
        }
      } else {
        for (int i = 0; i < member.length; i++) {
          member[i]['amountToPaid'] =
              double.parse(valueController.text) / member.length;
        }
      }
    }
    update();
  }

  lastStateOfExpense() {
    for (var element in member) {
      if (element['amount'] < element['amountToPaid']) {
        owner.add({
          'user': element['user'],
          'amount': element['amountToPaid'] - element['amount']
        });
      } else {
        payer.add({
          'user': element['user'],
          'amount': -element['amountToPaid'] + element['amount']
        });
      }
    }
    update();
  }

  void setRelationBetweenMembers() {
    List<Map<String, dynamic>> temp = [];
    temp = [...owner];
    for (int i = 0; i < temp.length; i++) {
      temp[i]['payer'] = [];
    }
    for (int i = 0; i < payer.length; i++) {
      payer[i]['owner'] = [];
      double amount = payer[i]['amount'];
      for (int j = 0; j < owner.length; j++) {
        if (amount == 0) {
          break;
        }
        if (owner[j]['amount'] == 0) {
          continue;
        }
        if (amount > owner[j]['amount']) {
          payer[i]['owner'].add({
            'user': owner[j]['user'],
            'amount': owner[j]['amount'],
          });
          temp[j]['payer']
              .add({'user': payer[i]['user'], 'amount': owner[j]['amount']});

          amount -= owner[j]['amount'];

          owner[j]['amount'] = 0;
        } else {
          payer[i]['owner'].add({
            'user': owner[j]['user'],
            'amount': amount,
          });
          temp[j]['payer'].add({'user': payer[i]['user'], 'amount': amount});
          owner[j] = {
            'user': owner[j]['user'],
            'amount': owner[j]['amount'] - amount
          };

          amount = 0;
        }
      }
    }
    owner = temp;
  }

  onSave() {
    getNeedToPayEachMember();
    // lastStateOfExpense();
    // setRelationBetweenMembers();

    // setRelationBetweenMembers();
    print('---- PAYERS' + payer.toString());
    print('---- OWNERS' + owner.toString());

    // if (saveExpenseError().isNotEmpty) {
    //   Get.snackbar('Cannot save expense', saveExpenseError().toString(),
    //       backgroundColor: Colors.red,
    //       snackPosition: SnackPosition.BOTTOM,
    //       colorText: Colors.white);
    // } else {
    //   // else {
    //   ExpenseRepository.getIdOfExpenseInGroup(groupId: groupModel!.id!)
    //       .then((value) {
    //     final newExpense = ExpenseModel(
    //         id: value,
    //         name: descriptionController.text,
    //         dateCreate: DateTime.now(),
    //         value: valueController.text,
    //         members: membersOfExpense);
    //     ExpenseRepository.setExpenseOnGroupCollection(
    //             groupId: groupModel!.id!, expenseModel: newExpense)
    //         .whenComplete(() async {
    //       await ExpenseRepository.setPayerAndOwnerOfExpense(
    //           groupId: groupModel!.id!,
    //           expenseId: value,
    //           payersData: payer,
    //           ownersData: owner);
    //       await GroupRepository.setStatusGroup(
    //           groupId: groupModel!.id!, data: payer, isPayer: true);
    //       await GroupRepository.setStatusGroup(
    //           groupId: groupModel!.id!, data: owner, isPayer: false);

    //       groupController.onInit();
    //       Get.back();
    //     });
    //   });
    // }
    // }
  }

  onChoosePayer(UserModel member) {
    if (!isMultiChoiceMode) {
      payer = [
        ({'user': member, 'amount': valueController.text})
      ];
    }

    update();
  }

  switchMultiChoiceMode() {
    isMultiChoiceMode = !isMultiChoiceMode;
    update();
  }

  swtichToUnequallyOption(int index) {
    isOnSplitUnequallyMode = (index == 1);

    update();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    valueController.dispose();

    super.onClose();
  }
}
