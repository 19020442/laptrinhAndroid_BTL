import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_member_controller.dart';
import 'package:no_name_app/repo/group_repository.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddMemberController(),
        builder: (AddMemberController _controller) {
          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _controller.onSave();
              },
              child: const Text("SAVE"),
            ),
            body: Column(
              children: [
                Container(
                  height: 200,
                  child: Row(
                    children: [
                      for (int i = 0;
                          i < _controller.friendsAreChosen.length;
                          i++)
                        CircleAvatar(
                          child: Text(_controller.friendsAreChosen[i].name!),
                        )
                    ],
                  ),
                ),
                for (int i = 0; i < _controller.yourFriends.length; i++)
                  ListTile(
                    onTap: () {
                      _controller.onClickFriend(_controller.yourFriends[i]);
                    },
                    leading: Text('$i'),
                    title: Text(_controller.yourFriends[i].name!),
                  )
              ],
            ),
          );
        });
  }
}
