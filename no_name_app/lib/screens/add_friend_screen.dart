import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_friend_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddFriendController(),
        builder: (AddFriendController _controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Thêm bạn mới', style: FontUtils.mainTextStyle.copyWith(),),
              actions: [
                IconButton(
                    onPressed: () {
                      _controller.onSave();
                    },
                    icon: const Icon(Icons.navigate_next_sharp))
              ],
            ),
            body: Padding(
              padding:const  EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text('Địa chỉ email', style: FontUtils.mainTextStyle.copyWith(
                    fontWeight:FontWeight.bold,
                    fontSize:  17
                  ),),
                  TextFormField(
                    controller: _controller.emailOrPhoneController,
                    style: FontUtils.mainTextStyle.copyWith(),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
