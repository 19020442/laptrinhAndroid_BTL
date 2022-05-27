import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/login_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (LoginController _controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Đăng ký',
              style: FontUtils.mainTextStyle.copyWith(),
            ),
          ),
        );
      },
    );
  }
}
