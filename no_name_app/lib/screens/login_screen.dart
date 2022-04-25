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
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Stack(
                children: [
                  Container(
                    width: deviceSize.width,
                    height: deviceSize.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // image: DecorationImage(
                      //     fit: BoxFit.fitHeight,
                      //     image: ExactAssetImage(ImageUtils.background_login))
                    ),
                  ),
                  Center(
                    child: LoginOptionItem(
                        title: 'Login with Google',
                        image: IconUtils.icGoogle,
                        onTap: () {
                          _controller.loginWithGoogle();
                        }),
                    // child: Container(
                    //   padding: const EdgeInsets.all(10),
                    //   height: 400,
                    //   width: 300,
                    //   decoration: BoxDecoration(
                    //       color: Colors.blueGrey[800],
                    //       borderRadius: BorderRadius.circular(15)),
                    //   child: Column(
                    //     children: [
                    //       LoginOptionItem(
                    //           title: 'Login with Google',
                    //           image: IconUtils.icGoogle,
                    //           onTap: () {})
                    //     ],
                    //   ),
                    // ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class LoginOptionItem extends StatelessWidget {
  const LoginOptionItem({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        // width: 300,
        decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(5),
            border: Border(
              bottom: BorderSide(width: 4,color: Colors.grey),
              left: BorderSide(width: 1,color: Colors.grey),
              top: BorderSide(width: 1,color: Colors.grey),
              right: BorderSide(width: 1,color: Colors.grey),
              ),
            
        
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              style: FontUtils.mainTextStyle.copyWith(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
