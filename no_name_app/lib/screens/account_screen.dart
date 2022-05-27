import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/account_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AccountController(),
        builder: (AccountController _controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 75,
                ),
                Text(
                  'Tài khoản',
                  style: FontUtils.mainTextStyle
                      .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                ListTile(
                  leading: const CircleAvatar(),
                  title: Text(
                    _controller.userModel.name!,
                    style: FontUtils.mainTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    _controller.userModel.email!,
                    style: FontUtils.mainTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                GestureDetector(
                    onTap: () {
                      if (_controller.userModel.passCode == '') {
                        Get.toNamed(Routes.PASSCODE_SCREEN,
                            arguments: {'mode': 'set-pass'});
                      } else {
                        Get.dialog(Dialog(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              // height: 100,
                              height: 150,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Cài đặt mã bảo mật',
                                    style: FontUtils.mainTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.toNamed(Routes.PASSCODE_SCREEN,
                                            arguments: {'mode': 'change-pass'});
                                      },
                                      child: Text('Thay đổi mã khóa',
                                          style: FontUtils.mainTextStyle
                                              .copyWith())),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                        Get.toNamed(Routes.PASSCODE_SCREEN,
                                            arguments: {'mode': 'delete-pass'});
                                      },
                                      child: Text(
                                        'Xóa mã khóa',
                                        style:
                                            FontUtils.mainTextStyle.copyWith(),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ));
                      }
                    },
                    child: AccountSettingItem(
                        leadingIcon: IconUtils.icPassCode,
                        title: 'Cài đặt khóa')),
                GestureDetector(
                    onTap: () {
                      _controller.logOut();
                    },
                    child: AccountSettingItem(
                        leadingIcon: IconUtils.icLogOut, title: 'Đăng xuất')),
              ],
            ),
          );
        });
  }
}

class AccountSettingItem extends StatelessWidget {
  const AccountSettingItem(
      {required this.leadingIcon, required this.title, Key? key})
      : super(key: key);
  final String leadingIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SvgPicture.asset(
            leadingIcon,
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 50,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: FontUtils.mainTextStyle.copyWith(fontSize: 18),
          )
        ]));
  }
}
