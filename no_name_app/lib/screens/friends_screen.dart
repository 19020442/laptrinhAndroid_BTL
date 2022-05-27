import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/friend_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/new_group_button.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: FriendController(),
        builder: (FriendController _controller) {
          return _controller.isLoadingFriend
              ? SpinKitThreeInOut(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      height: 20,
                      width: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index.isEven ? Colors.blue : Colors.grey,
                        ),
                      ),
                    );
                  },
                )
              : Column(
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
                    // const Text('You are settled up!'),
                    // if (!_controller.loadingFriendsDone)
                    //   const CircularProgressIndicator(),
                    // if (_controller.loadingFriendsDone)
                    for (int i = 0; i < _controller.listFriends.length; i++)
                      ListTile(
                        // leading: Text(
                        //   '$i',
                        //   style: FontUtils.mainTextStyle.copyWith(),
                        // ),
                        title: Text(
                          _controller.listFriends[i].name!,
                          style: FontUtils.mainTextStyle.copyWith(),
                        ),
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
                );
        });
  }
}
