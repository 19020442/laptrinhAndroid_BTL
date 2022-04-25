import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_friend_controller.dart';

class AddFriendScreen extends StatelessWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddFriendController(),
        builder: (AddFriendController _controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add a new contact'),
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
                  Text('Name'),
                  TextFormField(
                    controller: _controller.nameFriendController,
                  ),
                  Text('Phone number or email address'),
                  TextFormField(
                    controller: _controller.emailOrPhoneController,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
