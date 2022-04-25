import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';

class UploadRepository {
  static Future<String> uploadFile(String filePath) async {
    AuthController _authController = Get.find();
    File file = File(filePath);
    String fileName = basename(filePath);
    SettableMetadata metadata =
        SettableMetadata(customMetadata: <String, String>{
      'userId': _authController.userModel!.id!,
    });
    final result = await FirebaseStorage.instance
        .ref('user/${_authController.userModel!.id}/avatar/$fileName')
        .putFile(file, metadata)
        .onError((error, stackTrace) =>
            throw FirebaseException(plugin: 'upload-exception'));
    return await result.ref.getDownloadURL();
  }
}
