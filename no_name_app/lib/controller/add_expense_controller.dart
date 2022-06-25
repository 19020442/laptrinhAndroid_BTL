import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/screens/choose_who_paid_screen.dart';
import 'package:no_name_app/screens/option_split_screen.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class AddExpenseController extends GetxController {
  FocusNode initFocus = FocusNode();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController amountPaidController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late UserModel currentUser;
  GroupModel? groupModel;
  MyGroupController groupController = Get.find();
  // GroupController groupsController = Get.find();

  List<UserModel> membersOfExpense = [];
  bool isMultiChoiceMode = false;
  List<Map<String, dynamic>> member = [];
  List<Map<String, dynamic>> payer = [];
  List<Map<String, dynamic>> owner = [];
  List<TextEditingController> amountPerPayer = [];
  List<Map<String, dynamic>> temp = [];
  late UserModel memberTapped;
  final formKey = GlobalKey<FormState>();

  DateTime pickedDate = DateTime.now();

  // slpit unqually var
  bool isOnSplitUnequallyMode = false;
  List<TextEditingController> percentMemberController = [];
  List<Map<String, dynamic>> percentOfExpense = [];
  double totalPercentCurrently = 0;
  final formKeySplitPercent = GlobalKey<FormState>();

  late int cateIndexSelected = 0;

  late String splitText = "Đều";
  late String payers = "Bạn";
  @override
  void onInit() {
    groupModel = Get.arguments['group-model'];
    currentUser = Get.arguments['user-model'];
    memberTapped = currentUser;
    groupModel!.members = groupController.listMember;

    membersOfExpense = groupModel!.members!;

    amountPerPayer = List<TextEditingController>.filled(
        membersOfExpense.length, TextEditingController());

    for (int i = 0; i < membersOfExpense.length; i++) {
      member.add({'user': membersOfExpense[i], 'amount': 0});
      percentMemberController.add(TextEditingController());
    }
    initFocus.requestFocus();

    update();
    super.onInit();
  }

  List<String> saveExpenseError() {
    List<String> errors = [];
    if (descriptionController.text == "") {
      errors.add('Thiếu tên hóa đơn');
    }
    if (valueController.text == "") {
      errors.add('Cần phải có giá trị của hóa đơn');
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
    if (isMultiChoiceMode) {
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
    } else {
      Get.back();
    }
  }

  getNeedToPayEachMember() {
    if (isOnSplitUnequallyMode) {
      if (totalPercentCurrently != 100.0) {
      } else {
        for (int i = 0; i < member.length; i++) {
          member[i]['amountToPaid'] = int.parse(valueController.text) *
              double.parse(percentMemberController[i].text) ~/
              100;
        }
      }
    } else {
      for (int i = 0; i < member.length; i++) {
        member[i]['amountToPaid'] =
            int.parse(valueController.text) / member.length;
      }
    }

    update();
  }

  lastStateOfExpense() {
    if (member.every((element) => element['amount'] == 0)) {
      // member[0]['user'] = currentUser;
      // member[0]['amount'] = double.parse(valueController.text);
      member[member
              .indexWhere((element) => element['user'].id == currentUser.id)]
          ['amount'] = int.parse(valueController.text);
    }

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
    // print(valu eController.text == "");
    Get.dialog(LoadingWidget());
    if (saveExpenseError().isNotEmpty) {
      Get.defaultDialog(
          title: 'Cannot save expense',
          middleText: 'You must fill all information',
          radius: 15);
    } else {
      getNeedToPayEachMember();
      lastStateOfExpense();
      setRelationBetweenMembers();

      ExpenseRepository.getIdOfExpenseInGroup(groupId: groupModel!.id!)
          .then((value) {
        final newExpense = ExpenseModel(
            id: value,
            name: descriptionController.text,
            dateCreate: pickedDate,
            value: valueController.text,
            members: membersOfExpense,
            note: noteController.text,
            type: 'new',
            category:
                IconUtils.icExpenseList[cateIndexSelected].keys.elementAt(0));
        ExpenseRepository.setExpenseOnGroupCollection(
                groupId: groupModel!.id!, expenseModel: newExpense)
            .whenComplete(() async {
          await ExpenseRepository.setPayerAndOwnerOfExpense(
              groupId: groupModel!.id!,
              expenseId: value,
              payersData: payer,
              ownersData: owner);
          await GroupRepository.setStatusGroup(
              groupId: groupModel!.id!, data: payer, isPayer: true);
          await GroupRepository.setStatusGroup(
              groupId: groupModel!.id!, data: owner, isPayer: false);

          // groupController.onInit();
          // groupsController.onInit();
          update();
          Get.back();
          Get.back();
        });
      });
    }
  }

  onChoosePayer(UserModel memberTapped1, int index) {
    if (!isMultiChoiceMode) {
      member[index]['user'] = memberTapped1;
      member[index]['amount'] = double.parse(valueController.text);
      memberTapped = memberTapped1;
      payers = memberTapped1.name!;
      if (memberTapped1.id == currentUser.id) {
        payers = "Bạn";
      }
    }

    update();
  }

  bool isTapped(UserModel thisMember) {
    return memberTapped.id == thisMember.id;
  }

  switchMultiChoiceMode() {
    isMultiChoiceMode = !isMultiChoiceMode;
    if (isMultiChoiceMode) {
payers = "Tất cả";
    }
    else {
      payers = memberTapped.name!;
    }
    
    update();
  }

  swtichToUnequallyOption(int index) {
    isOnSplitUnequallyMode = (index == 1);
    if (isOnSplitUnequallyMode) {
      splitText = "Theo phần trăm";
    } else {
      splitText = "Đều";
    }
    update();
  }

  openNote(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 5, right: 5),
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: Text(
                      'Thêm ghi chú',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextField(
                        controller: noteController,
                        style: FontUtils.mainTextStyle.copyWith(),
                        decoration: InputDecoration.collapsed(
                            hintText: "Thêm ghi chú",
                            hintStyle: FontUtils.mainTextStyle.copyWith()),
                        maxLines: 20,
                      ),
                    ),
                  )),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue),
                        child: Center(
                          child: Text(
                            'OK',
                            style: FontUtils.mainTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }

  Future<void> openDatePicker(BuildContext context) async {
    pickedDate = (await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
      confirmText: 'Chọn',
      cancelText: 'Quay lại',
    ))!;
  }

  openChoosePayer(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(child: ChooseWhoPaidScreen());
        });
  }

  openAdjustSplit(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 400,
                child: SplitOptionScreen()),
          );
        });
  }

  onSelectCategory(int index) {
    cateIndexSelected = index;
    update();
  }

  @override
  void onClose() {
    descriptionController.dispose();
    valueController.dispose();

    super.onClose();
  }
}
