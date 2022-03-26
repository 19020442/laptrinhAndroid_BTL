import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
  }

  loginWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

    User? user = (await _auth.signInWithCredential(credential)).user;
    UserModel? tempUser;
    try {
      tempUser = await UserRepository.getUserByEmail(email: user!.email!);

      AuthController _authController = Get.find();
      _authController.setUser(tempUser);
      print('---- TEMP USER FOUND' + tempUser!.toJson().toString());
      Get.offAndToNamed(Routes.HOME_SCREEN,
          arguments: {'user_model': tempUser});
    } catch (e) {
      UserModel userModel = UserModel();
      userModel.id = user!.uid;
      userModel.name = user.displayName;
      userModel.email = user.email;
      print('---- TEMP USER NOT FOUND' + userModel.toJson().toString());
      UserRepository.setUser(userModel).whenComplete(() {
        AuthController _authController = Get.find();
        _authController.userModel = userModel;
        _authController.setUser(userModel);
        update();
        Get.offAndToNamed(Routes.HOME_SCREEN,
            arguments: {'user_model': userModel});
      });
      // .then((value) {
      //
      //   Get.toNamed(Routes.HOME_SCREEN, arguments: {'user_model': userModel});
      // });
    }
  }
}

// print('----' + tempUser!.toJson().toString());
// if (tempUser == null) {

//   });
// } else {

// }
