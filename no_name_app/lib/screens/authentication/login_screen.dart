import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:no_name_app/controller/login_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GetBuilder(
        init: LoginController(),
        builder: (LoginController _controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: _controller.currentMode == AuthMode.StartPageMode
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Stack(
                        children: [
                          Container(
                            width: deviceSize.width,
                            height: deviceSize.height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Flexible(
                                  flex: 20,
                                  child: Container(
                                    width: deviceSize.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            ImageUtils.background_login),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(),
                                  flex: 1,
                                ),
                                Flexible(
                                  flex: 3,
                                  child: LoginOptionItem(
                                      colorFont: Colors.white,
                                      color: Colors.blue,
                                      title: 'Đăng ký',
                                      image: '',
                                      onTap: () {
                                        _controller.switchToSignUp();
                                      }),
                                ),
                                Flexible(
                                  child: Container(),
                                  flex: 1,
                                ),
                                Flexible(
                                    flex: 3,
                                    child: LoginOptionItem(
                                        colorFont: Colors.black,
                                        color: Colors.white,
                                        title: 'Đăng nhập',
                                        image: '',
                                        onTap: () {
                                          _controller.switchToLogin();
                                        })),
                                // SizedBox(
                                //   height: 20,
                                // ),

                                Flexible(
                                  child: Container(),
                                  flex: 1,
                                ),
                                Flexible(
                                    flex: 3,
                                    child: LoginOptionItem(
                                        colorFont: Colors.black,
                                        color: Colors.white,
                                        title: 'Đăng nhập bằng Google',
                                        image: IconUtils.icGoogle,
                                        onTap: () {
                                          _controller.loginWithGoogle();
                                        })),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : _controller.currentMode == AuthMode.SignUpMode
                      ? Stack(
                          children: [
                            Container(
                              width: deviceSize.width,
                              height: deviceSize.height,
                              color: Colors.white,
                            ),
                            Positioned(
                              bottom: -60,
                              left: -40,
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageUtils.background_sign_up,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    style: FontUtils.mainTextStyle.copyWith(),
                                    controller: _controller.userNameController,
                                    decoration: InputDecoration(
                                        labelStyle:
                                            FontUtils.mainTextStyle.copyWith(),
                                        hintText: 'Tên người dùng',
                                        hintStyle:
                                            FontUtils.mainTextStyle.copyWith()),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _controller.pickAvatar();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(_controller
                                                              .avatarSelected !=
                                                          ""
                                                      ? _controller
                                                          .avatarSelected
                                                      : ""),
                                                  fit: BoxFit.fill,
                                                ),
                                                border: Border.all(
                                                    color: Color(0xff546d94),
                                                    width: 3)),
                                            height: 150,
                                            width: 150,
                                            child:
                                                _controller.avatarSelected == ""
                                                    ? const Center(
                                                        child: Icon(Icons
                                                            .camera_alt_outlined),
                                                      )
                                                    : Container(),
                                          ),
                                        ),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextFormField(
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                                controller:
                                                    _controller.emailController,
                                                decoration: InputDecoration(
                                                    labelStyle: FontUtils
                                                        .mainTextStyle
                                                        .copyWith(),
                                                    hintText:
                                                        'Nhập địa chỉ email',
                                                    hintStyle: FontUtils
                                                        .mainTextStyle
                                                        .copyWith()),
                                              ),
                                              TextFormField(
                                                obscureText: true,
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                                controller: _controller
                                                    .passwordController,
                                                decoration: InputDecoration(
                                                    labelStyle: FontUtils
                                                        .mainTextStyle
                                                        .copyWith(),
                                                    hintText: 'Nhập mật khẩu',
                                                    hintStyle: FontUtils
                                                        .mainTextStyle
                                                        .copyWith()),
                                              ),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: ButtonWidget(
                                          fontColor: Colors.black,
                                            color: Colors.white,
                                            title: 'Quay lại',
                                            // image: '',
                                            onTap: () {
                                              _controller.backToStartPage();
                                            }),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Flexible(
                                        flex: 4,
                                        child: ButtonWidget(
                                          fontColor: Colors.white,
                                            color: const Color(0xff876967),
                                            title: 'Xong',
                                            // image: '',
                                            onTap: () {
                                              _controller.signUp();
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Stack(children: [
                          Container(
                            width: deviceSize.width,
                            height: deviceSize.height,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Chào mừng quay trở lại',
                                    style: FontUtils.mainTextStyle.copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Địa chỉ email',
                                    style: FontUtils.mainTextStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    style: FontUtils.mainTextStyle.copyWith(),
                                    controller: _controller.emailController,
                                    decoration: InputDecoration(
                                      labelStyle:
                                          FontUtils.mainTextStyle.copyWith(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Mật khẩu',
                                    style: FontUtils.mainTextStyle
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    style: FontUtils.mainTextStyle.copyWith(),
                                    controller: _controller.passwordController,
                                    decoration: InputDecoration(
                                      
                                      labelStyle:
                                          FontUtils.mainTextStyle.copyWith(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonWidget(
                                    fontColor: Colors.white,
                                      title: 'Đăng nhập',
                                      onTap: () {
                                        _controller.loginByEmailAndPassword();
                                      },
                                      color: Colors.green),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonWidget(
                                    fontColor: Colors.black,
                                      title: 'Quay lại',
                                      onTap: () {
                                        _controller.backToStartPage();
                                      },
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          )
                        ]));
        });
  }
}

class LoginOptionItem extends StatelessWidget {
  const LoginOptionItem({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
    required this.color,
    required this.colorFont,
  }) : super(key: key);

  final String title;
  final String image;
  final Function() onTap;
  final Color color;
  final Color colorFont;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // padding: const EdgeInsets.only(left: 10, right: 10),
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            // border:  Border.all(),
            // border: const Border(
            //   bottom: BorderSide(width: 4, color: Colors.grey),
            //   left: BorderSide(width: 1, color: Colors.grey),
            //   top: BorderSide(width: 1, color: Colors.grey),
            //   right: BorderSide(width: 1, color: Colors.grey),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (image != "")
                SvgPicture.asset(
                  image,
                  height: 30,
                  width: 30,
                ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: FontUtils.mainTextStyle
                    .copyWith(fontWeight: FontWeight.w700, color: colorFont),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.title,
    // required this.image,
    required this.onTap,
    required this.color,
    required this.fontColor,
  }) : super(key: key);

  final String title;
  // final String image;
  final Function() onTap;
  final Color color;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // padding: const EdgeInsets.only(left: 10, right: 10),
          height: 50,
          // width: 250,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            // border: const Border(
            //   bottom: BorderSide(width: 4, color: Colors.grey),
            //   left: BorderSide(width: 1, color: Colors.grey),
            //   top: BorderSide(width: 1, color: Colors.grey),
            //   right: BorderSide(width: 1, color: Colors.grey),
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // if (image != "")
              //   SvgPicture.asset(
              //     image,
              //     height: 30,
              //     width: 30,
              //   ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style:
                    FontUtils.mainTextStyle.copyWith(fontWeight: FontWeight.w700, color: fontColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
