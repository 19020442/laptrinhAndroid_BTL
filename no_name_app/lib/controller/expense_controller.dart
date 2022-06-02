import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/comment_model.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/expense_repository.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class ExpenseController extends GetxController {
  late ExpenseModel expenseModel;
  TextEditingController textCommentController = TextEditingController();
  List<CommentModel> listComment = [];
  late UserModel userModel;
  late GroupModel groupModel;
  bool isLoadingComment = true;
  late Stream expenseListener;
  List<String> status = [];
  @override
  void onInit() {
    expenseModel = Get.arguments['expense-model'];
    AuthController authController = Get.find();
    userModel = authController.userModel!;
    groupModel = Get.arguments['group-model'];
    expenseListener = FirebaseFirestore.instance
        .collection('groups')
        .doc(groupModel.id!)
        .collection('expenses')
        .doc(expenseModel.id)
        .collection('comments')
        .snapshots();
    listenOnExpense();
    ExpenseRepository.getStatusOfExpense(
            groupId: groupModel.id!, currentExpense: expenseModel)
        .then((value) {
      status = value;
      update();
    });
    super.onInit();
  }

  listenOnExpense() async {
    expenseListener.listen((event) {
      ExpenseRepository.getComments(
              groupId: groupModel.id!, currentExpense: expenseModel)
          .then((value) {
        listComment = value;
        isLoadingComment = false;
        update();
      });
      // update();
    });
  }

  onSendComment() {
    if (textCommentController.text != "") {
      Get.dialog(const LoadingWidget());
      ExpenseRepository.generateIdComment(
              groupId: groupModel.id!, currentExpense: expenseModel)
          .then((cmtId) {
        ExpenseRepository.addComment(
                groupId: groupModel.id!,
                currentExpense: expenseModel,
                commentModel: CommentModel(
                    content: textCommentController.text,
                    dateTime: DateTime.now(),
                    id: cmtId,
                    senderName: userModel.name))
            .then((_) {
          listComment.add(CommentModel(
              content: textCommentController.text,
              dateTime: DateTime.now(),
              id: cmtId,
              senderName: userModel.name));
          update();
          textCommentController.clear();
          Get.back();
        });
      });
    }
  }
}
