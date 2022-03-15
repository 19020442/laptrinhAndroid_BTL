import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/account_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AccountController(),
        builder: (AccountController _controller) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tài khoản', style: FontUtils.mainTextStyle.copyWith(
                  fontSize: 30
                ,
                fontWeight: FontWeight.w700
                ),),
                ListTile(
                  leading: const CircleAvatar(),
                  title:  Text(_controller.userModel.name!, style: FontUtils.mainTextStyle.copyWith(
                    fontSize: 16,
                  ),),
                  subtitle: Text(_controller.userModel.email!,style: FontUtils.mainTextStyle.copyWith(
                    fontSize: 16,
                  ),),
                ),
                const Divider(thickness: 1,),
                IconButton(onPressed: (){
                  _controller.logOut();
                }, icon: const Icon(Icons.logout,))
              ],
            ),
          );
        });
  }
}
