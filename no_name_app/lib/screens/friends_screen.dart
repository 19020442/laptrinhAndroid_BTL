import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/friend_controller.dart';
import 'package:no_name_app/widgets/new_group_button.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FriendController(),
        builder: (FriendController _controller) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Text('You are settled up!'),
                // if (!_controller.loadingFriendsDone)
                //   const CircularProgressIndicator(),
                // if (_controller.loadingFriendsDone)
                  for (int i = 0; i < _controller.listFriends.length; i++)
                    ListTile(
                      leading: Text('$i'),
                      title: Text(_controller.listFriends[i].name!),
                    ),
                GestureDetector(
                  onTap: () {
                    _controller.startAddNewFriend();
                  },
                  child: AddButton(
                      icon: const Icon(Icons.person_add),
                      title: 'Add more friends'
                      ),
                ),
              ],
            ),
          );
        });
  }
}
