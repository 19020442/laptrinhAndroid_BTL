import 'package:flutter/material.dart';

import 'package:toast/toast.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_member_controller.dart';

import 'package:no_name_app/utils/fonts.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GetBuilder(
        init: AddMemberController(),
        builder: (AddMemberController _controller) {
          return Scaffold(
            appBar: AppBar(
              brightness: Brightness.light,
              elevation: 5,
              backgroundColor: Colors.white,
              title: TextFormField(
                cursorColor: Colors.black,
                // keyboardType: inputType,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Enter name",
                    hintStyle: FontUtils.mainTextStyle.copyWith()),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.navigate_before,
                  color: Colors.blue,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _controller.onSave();
              },
              child: const Text("SAVE"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (_controller.friendsAreChosen.isNotEmpty)
                    SizedBox(
                      child: Row(
                        children: [
                          for (int i = 0;
                              i < _controller.friendsAreChosen.length;
                              i++)
                            Column(
                              children: [
                                CircleAvatar(),
                                Text(
                                  _controller.friendsAreChosen[i].name!,
                                  style: FontUtils.mainTextStyle.copyWith(),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  Text(
                    'Your friends',
                    style: FontUtils.mainTextStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < _controller.yourFriends.length; i++)
                          ListTile(
                            onTap: _controller
                                    .isJoined(_controller.yourFriends[i])
                                ? () => Toast.show(
                                    '${_controller.yourFriends[i].name} joined',
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom,
                                    backgroundColor: Colors.blue,
                                    textStyle: FontUtils.mainTextStyle
                                        .copyWith(color: Colors.white))
                                : () {
                                    _controller.onClickFriend(
                                        _controller.yourFriends[i]);
                                  },
                            trailing: Text(
                              _controller.isJoined(_controller.yourFriends[i])
                                  ? 'Joined'
                                  : '',
                              style: FontUtils.mainTextStyle.copyWith(),
                            ),
                            leading: CircleAvatar(),
                            title: Text(
                              _controller.yourFriends[i].name!,
                              style: FontUtils.mainTextStyle.copyWith(),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
