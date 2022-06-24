import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:no_name_app/controller/friend_controller.dart';
import 'package:no_name_app/models/activity_model.dart';

import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/activity_repository.dart';
import 'package:no_name_app/repo/friend_repository.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/utils/fonts.dart';

// font chu thi dc co

class AddFriendController extends GetxController {
  TextEditingController nameFriendController = TextEditingController();
  TextEditingController emailOrPhoneController = TextEditingController();
  late UserModel userModel;
  @override
  void onInit() {
    userModel = Get.arguments['user-model'];
    update();

    super.onInit();
  }

  bool validatorPhoneAndNumber() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailOrPhoneController.text);
    bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
        .hasMatch(emailOrPhoneController.text);
    if (emailValid || phoneValid) return true;
    return false;
  }

  onSave() async {
    if (!validatorPhoneAndNumber()) {
      Get.dialog(AlertDialog(
        title: const Text('ERROR'),
        content: const Text(
            'Email không hợp lệ, vui lòng thử lại'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'))
        ],
      ));
    } else {
      // FriendRepository.alreadyIsFriend(userId: userId, friendId: friendId)
      UserRepository.getUserByEmail(email: emailOrPhoneController.text)
          .then((value) {
        if (value == null) {
          Get.dialog(AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Oh, let me check again'))
            ],
            content: const Text(
                'Your friend\'s email or phone number is not exsist'),
          ));
        } else {
          FriendRepository.alreadyIsFriend(
                  userId: userModel.id!, friendId: value.id!)
              .then((value1) {
            if (value1) {
              Get.dialog(AlertDialog(
                content: Text(
                  'Add friend successfully!',
                  style: FontUtils.mainTextStyle.copyWith(),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        FriendRepository.addFriend(
                                user: userModel,
                                newFriend: UserModel(
                                    email: value.email,
                                    name: value.name,
                                    id: value.id,
                                    avatarImage: value.avatarImage))
                            .then((value) {
                          FriendController friendController = Get.find();
                          friendController.onInit();
                          ActivityRepository.generateIdOfActivity(
                                  actor: userModel)
                              .then((actId) {
                            ActivityRepository.addAnActivity(
                                actor: userModel,
                                activityModel: ActivityModel(
                                  id: actId,
                                  actor: userModel,
                                  timeCreate: DateTime.now(),
                                  type: TypeOfActivity.AddNewFriend,
                                  
                                )).then((value) {
                              Get.back();
                              Get.back();
                            });
                          });
                        });

                        // Get.back();
                        // Get.back(canPop: false);
                      },
                      child: Text(
                        'Ok, back to my friends screen',
                        style: FontUtils.mainTextStyle.copyWith(),
                      )),
                  TextButton(
                      onPressed: () {
                        nameFriendController.clear();
                        emailOrPhoneController.clear();
                        Get.back();
                      },
                      child: Text(
                        'Ok, I want add more!',
                        style: FontUtils.mainTextStyle.copyWith(),
                      ))
                ],
              ));
            } else {
              Get.dialog(AlertDialog(
                content: Text(
                  '${value.name} đã có sẵn trong danh sách bạn bè',
                  style: FontUtils.mainTextStyle.copyWith(),
                ),
              ));
            }
          });
        }
      });
    }
  }

  @override
  void onClose() {
    nameFriendController.dispose();
    emailOrPhoneController.dispose();
    super.onClose();
  }
}
