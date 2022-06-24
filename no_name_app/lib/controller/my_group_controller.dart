import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/controller/home_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/activity_repository.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/cached_image.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class MyGroupController extends GetxController {
  GroupModel currentGroup = GroupModel();
  late UserModel userModel;
  List<ExpenseModel> listExpenses = [];
  List<UserModel> listMember = [];
  List<Map<String, dynamic>> status = [];
  List<double> listState = [];
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();
  final formKeyEditName = GlobalKey<FormState>();

  @override
  void onInit() {
    currentGroup = Get.arguments['group-model'];
    // print( currentGroup.note == null);

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

      update();
    });
    GroupRepository.getStatusGroupByUserId(
            groupId: currentGroup.id!, userId: userModel.id!)
        .then((value) {
      status = value;

      for (int i = 0; i < status.length; i++) {
        UserRepository.getAvatarUserById(id: status[i]['id']).then((ava) {
          status[i]['avatar'] = ava;
          update();
        });
      }
      update();
    });

    super.onInit();
  }

  deleteGroup() {
    Get.dialog(const LoadingWidget());
    for (int i = 0; i < listMember.length; i++) {
      GroupRepository.leaveGroup(uid: listMember[i].id!, gid: currentGroup.id!)
          .then((value) =>
              GroupRepository.removeGroup(gid: currentGroup.id!).then((value) {
                ActivityRepository.generateIdOfActivity(actor: userModel)
                    .then((idAct) {
                  final anAct = ActivityModel(
                    id: idAct,
                    actor: userModel,
                    timeCreate: DateTime.now(),
                    type: TypeOfActivity.DeleteGroup,
                    useCase: currentGroup,
                    zone: null,
                  );
                  ActivityRepository.addAnActivity(
                          actor: userModel, activityModel: anAct)
                      .then((value) {
                    Get.back();
                    GroupController groupController = Get.find();
                    groupController.onInit();

                    Get.back();
                    Get.back();
                  });
                });
              }));
    }
  }

  leaveGroup() {
    Get.dialog(const LoadingWidget());

    GroupRepository.leaveGroup(uid: userModel.id!, gid: currentGroup.id!)
        .then((value) {
      ActivityRepository.generateIdOfActivity(actor: userModel).then((idAct) {
        final anAct = ActivityModel(
          id: idAct,
          actor: userModel,
          timeCreate: DateTime.now(),
          type: TypeOfActivity.LeaveGroup,
          useCase: currentGroup,
          zone: null,
        );
        ActivityRepository.addAnActivity(actor: userModel, activityModel: anAct)
            .then((value) {
          Get.back();
          GroupController groupController = Get.find();
          groupController.onInit();

          Get.back();
          Get.back();
        });
      });
    });
  }

  addMember(List<UserModel> list) {
    listMember.addAll(list);
    update();
  }

  openWhiteBoard(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: Form(
              key: formKey,
              // padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, right: 5),
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,
                      child: Text(
                        'Ghi chú',
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: TextFormField(
                          initialValue: currentGroup.note.toString(),
                          onSaved: (value) {
                            currentGroup.note = value;
                            update();
                          },
                          // controller: noteController,
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
                          Get.dialog(LoadingWidget());
                          formKey.currentState!.save();
                          GroupRepository.updateGroup(
                                  gid: currentGroup.id!,
                                  arguments: {'Note': currentGroup.note})
                              .then((value) {
                            Get.back();
                            Get.back();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Lưu',
                              style: FontUtils.mainTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  openEditGroup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 150,
              child: Column(
                children: [
                  Form(
                    key: formKeyEditName,
                    child: TextFormField(
                      initialValue: currentGroup.nameGroup,
                      style: FontUtils.mainTextStyle.copyWith(),
                      onSaved: (value) {
                        currentGroup.nameGroup = value;
                        update();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Get.dialog(LoadingWidget());
                          formKeyEditName.currentState!.save();
                          GroupRepository.updateGroup(
                                  gid: currentGroup.id!,
                                  arguments: {'Name': currentGroup.nameGroup})
                              .then((value) {
                            Get.back();
                            Get.back();
                          });
                        },
                        child: Container(
                          color: Colors.blue,
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Text(
                              'Lưu',
                              style: FontUtils.mainTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }

  openBalances(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog(
            child: Container(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    color: Colors.blue,
                    height: 50,
                    width: 300,
                    child: Text(
                      'Chi tiết',
                      style: FontUtils.mainTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (int i = 0; i < status.length; i++)
                            if (status[i]['amount'].toString() != "0.0")
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  status[i]['amount'] < 0
                                      ? 'Bạn mượn ${status[i]['name']} ${status[i]['amount'] * -1} vnđ'
                                      : status[i]['name'] +
                                          " mượn bạn " +
                                          status[i]['amount'].toString() +
                                          " vnđ",
                                  style: FontUtils.mainTextStyle.copyWith(),
                                ),
                              )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
