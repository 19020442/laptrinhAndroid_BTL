import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:no_name_app/controller/friend_controller.dart';

import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/friend_repository.dart';
import 'package:no_name_app/repo/user_repo.dart';

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
            'You did not enter a valid email address or phone number. Check carefully and try again!'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'))
        ],
      ));
    } else {
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
          Get.dialog(AlertDialog(
            content: const Text('Add friend successfully!'),
            actions: [
              TextButton(
                  onPressed: () {
                    FriendRepository.addFriend(
                        userId: userModel.id!,
                        newFriend: UserModel(
                          email: value.email,
                          name: value.name,
                          id: value.id,
                        )).then((value) {
                      FriendController friendController = Get.find();
                      friendController.onInit();
                      Get.back();
                      Get.back();
                    });

                    // Get.back();
                    // Get.back(canPop: false);
                  },
                  child: const Text('Ok, back to my friends screen')),
              TextButton(
                  onPressed: () {
                    nameFriendController.clear();
                    emailOrPhoneController.clear();
                    Get.back();
                  },
                  child: const Text('Ok, I want add more!'))
            ],
          ));
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
