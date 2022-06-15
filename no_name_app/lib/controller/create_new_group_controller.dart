import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/repo/activity_repository.dart';
import 'package:no_name_app/repo/group_repository.dart';
import 'package:no_name_app/repo/upload_repository.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/loading_widget.dart';
import 'package:no_name_app/widgets/type_of_group_widget.dart';

class CreateNewGroupController extends GetxController {
  TextEditingController nameGroupController = TextEditingController();
  late String imageGroup = "";
  late String typeGroup = "";
  List<IconData> listIconTypeOfGroup = [
    Icons.airplanemode_active,
    Icons.home,
    Icons.list_alt,
  ];
  late int heightScreen = 400;
  List<String> titleEachGroup = [
    'Trip',
    'Home',
    'Other',
  ];
  int typeOfGroupIndexChoosen = 2;

  pickImage() async {
    Get.dialog(const LoadingWidget());
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? file =
          await _picker.pickImage(source: ImageSource.gallery).whenComplete(() {
        Get.back();
      });
      if (file != null) {
        Get.dialog(const LoadingWidget());
        await UploadRepository.uploadFile(file.path).then((value) {
          imageGroup = value;
          update();
          Get.back();
        });
      }
    } catch (e) {
      Get.back();
    }
  }

  onSelectTypeGroup(int index) {
    typeGroup = titleEachGroup[index];
    typeOfGroupIndexChoosen = index;
    update();
  }

  String errorInfoFillGroup() {
    if (nameGroupController.text == "") {
      return 'MISSING NAME OF GROUP';
    }
    // if (typeGroup == "") {
    //   return 'MISSING TYPE OF GROUP';
    // }

    return '';
  }

  onSave() async {
    Get.dialog(const LoadingWidget());
    if (errorInfoFillGroup() == "") {
      GroupModel newGroup = GroupModel();

      GroupRepository.getIdGroup().then((value) {
        newGroup.id = value;
        newGroup.imageGroup = imageGroup;
        newGroup.nameGroup = nameGroupController.text;
        newGroup.typeGroup = typeGroup == "" ? "Other" : typeGroup;
        newGroup.members = [];
        newGroup.note = '';
        GroupRepository.setGroup(newGroup);
        AuthController authController = Get.find();
        GroupRepository.addMember(
            group: newGroup, listMemberAdd: [authController.userModel!]);

        UserRepository.onCreateGroup(
                uid: authController.userModel!.id!, groupModel: newGroup)
            .then((_) {
          ActivityRepository.generateIdOfActivity(
                  actor: authController.userModel!)
              .then((idAct) {
            ActivityRepository.addAnActivity(
                    actor: authController.userModel!,
                    activityModel: ActivityModel(
                        id: idAct,
                        actor: authController.userModel,
                        timeCreate: DateTime.now(),
                        type: TypeOfActivity.CreateNewGroup,
                        useCase: newGroup,
                        zone: null))
                .then((value) {
              update();
              GroupController groupController = Get.find();
              groupController.onInit();
              Get.back();
              Get.offAndToNamed(Routes.MY_GROUP_SCREEN, arguments: {
                'group-model': newGroup,
                'user-model': authController.userModel
              });
            });
          });
        });
      });
    } else {
      Get.back();
      Get.snackbar('ERROR CREATING', errorInfoFillGroup(),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
    }
  }
  expandScreen() {
    // print('abcd');
    // heightScreen = 900;
    update();
  }
}
