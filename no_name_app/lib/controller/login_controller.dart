import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/repo/user_repo.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/login_screen.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/loading_widget.dart';

enum AuthMode { LoginMode, SignUpMode, StartPageMode }

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentMode = AuthMode.StartPageMode;
  var listAvatar = [
    AvatarUtils.avatar1,
    AvatarUtils.avatar2,
    AvatarUtils.avatar3,
    AvatarUtils.avatar4,
    AvatarUtils.avatar5,
    AvatarUtils.avatar6,
  ];
  var avatarSelect = "";
  var avatarSelected = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  String checkValidSignUpForm() {
    if (avatarSelected == "") {
      return "Bạn cần chọn một ảnh đại diện";
    } else if (emailController.text.isEmpty) {
      return "Vui lòng nhập địa chỉ email";
    } else if (passwordController.text.isEmpty) {
      return "Vui lòng nhập mật khẩu";
    } else if (userNameController.text.isEmpty) {
      return "Bạn chưa điền thông tin tên người dùng";
    }
    return "";
  }

  signUp() async {
    if (checkValidSignUpForm() != "") {
      Get.dialog(AlertDialog(
        title: Text(
          'Thiếu thông tin',
          style: FontUtils.mainTextStyle.copyWith(
            color: Colors.red[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          checkValidSignUpForm(),
          style: FontUtils.mainTextStyle.copyWith(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'OK',
                style: FontUtils.mainTextStyle.copyWith(),
              ))
        ],
      ));
    } else {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        UserModel res = UserModel(
            id: value.user!.uid,
            email: value.user!.email,
            name: userNameController.text,
            avatarImage: avatarSelected,
            passCode: '');

        // print("Created New Account");
        UserRepository.setUser(res);
        AuthController _authController = Get.find();
        _authController.setUser(res);
        Get.offAndToNamed(Routes.HOME_SCREEN, arguments: {'user_model': res});
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => HomeScreen()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    }
  }

  loginByEmailAndPassword() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      UserRepository.getUserByEmail(email: value.user!.email!).then((isEx) {
        if (isEx == null) {
        } else {
          AuthController _authController = Get.find();
          _authController.setUser(isEx);

          if (isEx.passCode == '') {
            Get.offAndToNamed(Routes.HOME_SCREEN,
                arguments: {'user_model': isEx});
          } else {
            Get.offAndToNamed(Routes.PASSCODE_SCREEN,
                arguments: {'mode': 'enter-pass'});
          }
        }
      });
    }).onError((error, stackTrace) {
      Get.dialog(AlertDialog(
        title: Text(
          'Đăng nhập không thành công',
          style: FontUtils.mainTextStyle.copyWith(
            color: Colors.red[300],
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          error.toString(),
          style: FontUtils.mainTextStyle.copyWith(),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'OK',
                style: FontUtils.mainTextStyle.copyWith(),
              ))
        ],
      ));
    });
    ;
  }

  loginWithGoogle() async {
    // Get.dialog(LoadingWidget());
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
    print(credential);
    User? user = (await _auth.signInWithCredential(credential)).user;
    print(user);
    UserModel? tempUser =
        await UserRepository.getUserByEmail(email: user!.email!);

    if (tempUser == null) {
      UserModel userModel = UserModel();
      userModel.id = user.uid;
      userModel.name = user.displayName;
      userModel.email = user.email;
      userModel.avatarImage = user.photoURL;
      userModel.passCode = '';

      UserRepository.setUser(userModel);
      Get.back();
      Get.toNamed(Routes.HOME_SCREEN, arguments: {'user_model': userModel});
      AuthController _authController = Get.find();
      _authController.setUser(userModel);
    } else {
      AuthController _authController = Get.find();
      _authController.setUser(tempUser);
      // Get.back();
      if (tempUser.passCode == '') {
        Get.offAndToNamed(Routes.HOME_SCREEN,
            arguments: {'user_model': tempUser});
      } else {
        Get.offAndToNamed(Routes.PASSCODE_SCREEN,
            arguments: {'mode': 'enter-pass'});
      }
    }
  }

  switchToSignUp() {
    currentMode = AuthMode.SignUpMode;
    update();
  }

  switchToLogin() {
    currentMode = AuthMode.LoginMode;
    update();
  }

  backToStartPage() {
    currentMode = AuthMode.StartPageMode;
    update();
  }

  onChooseAvatar(String ava) {
    avatarSelect = ava;
    update();
  }

  pickAvatar() {
    Get.dialog(Dialog(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return SizedBox(
          height: 600,
          width: 400,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Chọn ảnh đại diện',
                  style: FontUtils.mainTextStyle
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(avatarSelect), fit: BoxFit.fill),
                ),
              ),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: [
                    for (int i = 0; i < listAvatar.length; i++)
                      Card(
                        elevation: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => onChooseAvatar(listAvatar[i]));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: NetworkImage(listAvatar[i]),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              ButtonWidget(
                fontColor: Colors.white,
                title: 'Xác nhận',
                onTap: () {
                  Get.back();
                  avatarSelected = avatarSelect;
                  update();
                },
                color: const Color(0xff876967),
              )
            ],
          ),
        );
      }),
    ));
  }
}
