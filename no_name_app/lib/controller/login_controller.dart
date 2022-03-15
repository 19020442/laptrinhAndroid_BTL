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

    UserModel? tempUser =
        await UserRepository.getUserByEmail(email: user!.email!);
    // print(tempUser!.toJson());
    if (tempUser == null) {
   
      UserModel userModel = UserModel();
      userModel.id = user.uid;
      userModel.name = user.displayName;
      userModel.email = user.email;

      Get.toNamed(Routes.REGISTER_SCREEN, arguments: {'user_model': userModel});
    } else {
    
      AuthController _authController = Get.find();
      _authController.setUser(tempUser);
      Get.offAndToNamed(Routes.HOME_SCREEN, arguments: {'user_model': tempUser});
    }
  }
}
