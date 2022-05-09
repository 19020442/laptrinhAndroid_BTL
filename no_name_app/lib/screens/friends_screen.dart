import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/friend_controller.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/new_group_button.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FriendController(),
        builder: (FriendController _controller) {
          return  Column(
              children: [
                SizedBox(
                  height: 75,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset(IconUtils.icSearch),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                Divider(),
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
                      icon: const Icon(
                        Icons.person_add,
                        color: Colors.white,
                      ),
                      title: 'Add more friends'),
                ),
              ],
          
          )
          ;
        });
  }
}
