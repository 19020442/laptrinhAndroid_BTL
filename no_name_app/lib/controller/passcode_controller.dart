// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

enum PassCodeSettingMode {
  Step1SetPass,
  Step2SetPass,
  EnterPass,
  DeletePass,
  ChangePass
}

class PassCodeController extends GetxController {
  late UserModel userModel;
  final AuthController _authController = Get.find();
  PassCodeSettingMode modePassCode = PassCodeSettingMode.EnterPass;

  List<String> currentStatePasscode = ['', '', '', ''];
  List<String> stateConfirmPassCode = ['', '', '', ''];

  int currentIndex = 0;
  PassCodeSettingMode stateEnterPassCode = PassCodeSettingMode.EnterPass;

  @override
  void onInit() {
    userModel = _authController.userModel!;
    try {
      switch (Get.arguments['mode']) {
        case 'set-pass':
          stateEnterPassCode = PassCodeSettingMode.Step1SetPass;
          break;
        case 'delete-pass':
          stateEnterPassCode = PassCodeSettingMode.DeletePass;
          break;
        case 'change-pass':
          stateEnterPassCode = PassCodeSettingMode.ChangePass;
          break;
      }
    } catch (e) {
      print('arg mode is null, state now is enterpass....');
    }

    super.onInit();
  }

  onTapKeyBoard(String text) {
    if (stateEnterPassCode == PassCodeSettingMode.Step1SetPass) {
      if (text == 'delete') {
        currentStatePasscode[currentIndex - 1] = '';
        currentIndex--;
      } else {
        currentStatePasscode[currentIndex] = text;
        currentIndex++;
        // print(currentStatePasscode);
        if (currentIndex == 4) {
          stateEnterPassCode = PassCodeSettingMode.Step2SetPass;
          currentIndex = 0;
        }
      }
      update();
    } else if (stateEnterPassCode == PassCodeSettingMode.Step2SetPass) {
      if (text == 'delete') {
        stateConfirmPassCode[currentIndex - 1] = '';
        currentIndex--;
      } else {
        stateConfirmPassCode[currentIndex] = text;
        currentIndex++;
        // print(currentStatePasscode);
        if (currentIndex == 4) {
          // stateEnterPassCode = PassCodeSettingMode.Step2SetPass;

          validationSetPassCode();
        }
      }
      update();
    } else if (stateEnterPassCode == PassCodeSettingMode.EnterPass) {
      if (text == 'delete') {
        currentStatePasscode[currentIndex - 1] = '';
        currentIndex--;
      } else {
        currentStatePasscode[currentIndex] = text;
        currentIndex++;
        // print(currentStatePasscode);
        if (currentIndex == 4) {
          // stateEnterPassCode = PassCodeSettingMode.Step2SetPass;
          // currentIndex = 0;
          checkPassCode();
        }
      }
      update();
    } else if (stateEnterPassCode == PassCodeSettingMode.DeletePass) {
      if (text == 'delete') {
        currentStatePasscode[currentIndex - 1] = '';
        currentIndex--;
      } else {
        currentStatePasscode[currentIndex] = text;
        currentIndex++;
        // print(currentStatePasscode);
        if (currentIndex == 4) {
          // stateEnterPassCode = PassCodeSettingMode.Step2SetPass;
          // currentIndex = 0;
          checkPassCode();
        }
      }
      update();
    } else if (stateEnterPassCode == PassCodeSettingMode.ChangePass) {
      if (text == 'delete') {
        currentStatePasscode[currentIndex - 1] = '';
        currentIndex--;
      } else {
        currentStatePasscode[currentIndex] = text;
        currentIndex++;
        // print(currentStatePasscode);
        if (currentIndex == 4) {
          // stateEnterPassCode = PassCodeSettingMode.Step2SetPass;
          // currentIndex = 0;
          Get.dialog(const LoadingWidget());
          UserRepository.updateUser(uid: userModel.id!, arguments: {
            'passcode': currentStatePasscode[0] +
                currentStatePasscode[1] +
                currentStatePasscode[2] +
                currentStatePasscode[3],
          }).then((value) {
            userModel.passCode = currentStatePasscode[0] +
                currentStatePasscode[1] +
                currentStatePasscode[2] +
                currentStatePasscode[3];
            _authController.setUser(userModel);
            Get.back();
            resetState();
            Get.back();
          });
        }
      }
      update();
    }

    update();
  }

  checkPassCode() {
    final entered = currentStatePasscode[0] +
        currentStatePasscode[1] +
        currentStatePasscode[2] +
        currentStatePasscode[3];
    if (stateEnterPassCode == PassCodeSettingMode.EnterPass) {
      if (entered == userModel.passCode) {
        // _authController.setUser(res);
        Get.offAndToNamed(Routes.HOME_SCREEN,
            arguments: {'user_model': userModel});
      } else {
        Get.dialog(AlertDialog(
          title: Text(
            'Sai mã bảo mật',
            style: FontUtils.mainTextStyle
                .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Mã xác nhận sai',
            style: FontUtils.mainTextStyle.copyWith(),
          ),
          actions: [
            // TextButton(
            //     onPressed: () {
            //       resetState();
            //       Get.back();
            //       update();
            //     },
            //     child: Text(
            //       'Thiết lập mã lại từ đầu',
            //       style: FontUtils.mainTextStyle.copyWith(),
            //     ))
          ],
        ));
      }
    } else if (stateEnterPassCode == PassCodeSettingMode.DeletePass) {
      if (entered == userModel.passCode) {
        Get.dialog(const LoadingWidget());
        UserRepository.updateUser(
            uid: userModel.id!, arguments: {'passcode': ''}).then((value) {
          userModel.passCode = '';
          _authController.setUser(userModel);
          Get.back();
          Get.back();
        });
        // _authController.setUser(res);

      } else {
        Get.dialog(AlertDialog(
          title: Text(
            'Sai mã bảo mật',
            style: FontUtils.mainTextStyle
                .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Mã xác nhận sai',
            style: FontUtils.mainTextStyle.copyWith(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  resetState();
                  Get.back();
                },
                child: Text(
                  'Nhập lại',
                  style: FontUtils.mainTextStyle.copyWith(),
                ))
          ],
        ));
      }
    }
  }

  validationSetPassCode() {
    Function compare = const ListEquality().equals;

    final res = (compare(currentStatePasscode, stateConfirmPassCode));
    if (res == false) {
      Get.dialog(AlertDialog(
        title: Text(
          'Cài đặt mã thất bại',
          style: FontUtils.mainTextStyle
              .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Mã xác nhận không khớp',
          style: FontUtils.mainTextStyle.copyWith(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                resetState();
                Get.back();
                update();
              },
              child: Text(
                'Thiết lập mã lại từ đầu',
                style: FontUtils.mainTextStyle.copyWith(),
              ))
        ],
      ));
    } else {
      Get.dialog(const LoadingWidget());
      final pass = stateConfirmPassCode[0] +
          stateConfirmPassCode[1] +
          stateConfirmPassCode[2] +
          stateConfirmPassCode[3];

      UserRepository.updateUser(uid: userModel.id!, arguments: {
        'passcode': pass,
      }).then((value) {
        Get.back();
        userModel.passCode = pass;
        _authController.setUser(userModel);
        Get.dialog(AlertDialog(
          title: Text(
            'Cài đặt mã thành công',
            style: FontUtils.mainTextStyle
                .copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Mã bảo mật của bạn là: ' + pass,
            style: FontUtils.mainTextStyle.copyWith(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  resetState();
                  Get.back();
                  Get.back();
                  update();
                },
                child: Text(
                  'OK',
                  style: FontUtils.mainTextStyle.copyWith(),
                ))
          ],
        ));
        update();
      });
    }
  }

  resetState() {
    stateEnterPassCode = PassCodeSettingMode.Step1SetPass;
    currentIndex = 0;
    currentStatePasscode = ['', '', '', ''];
    stateConfirmPassCode = ['', '', '', ''];
    update();
  }
}
