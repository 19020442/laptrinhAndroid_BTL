import 'package:flutter/material.dart';
import 'package:no_name_app/widgets/cached_image.dart';

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
              // brightness: Brightness.light,
              elevation: 0,
              backgroundColor: Colors.blue,
              title: Text(
                'Thêm bạn bè vào nhóm',
                style: FontUtils.mainTextStyle
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              //  TextFormField(
              //   cursorColor: Colors.black,
              //   // keyboardType: inputType,
              //   decoration: InputDecoration(
              //       border: InputBorder.none,
              //       focusedBorder: InputBorder.none,
              //       enabledBorder: InputBorder.none,
              //       errorBorder: InputBorder.none,
              //       disabledBorder: InputBorder.none,
              //       hintText: "Nhập tên",
              //       hintStyle: FontUtils.mainTextStyle.copyWith()),
              // ),
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _controller.onSave();
              },
              child: Text(
                "HOÀN TẤT",
                style: FontUtils.mainTextStyle
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
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
                                Container(
                                  height: 50,
                                  width: 50,
                                  child: CachedImageWidget(
                                    url: _controller
                                        .friendsAreChosen[i].avatarImage,
                                  ),
                                ),
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
                    'Danh sách bạn bè',
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
                                    '${_controller.yourFriends[i].name} đã tham gia rồi!',
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
                                  ? 'Đã tham gia'
                                  : '',
                              style: FontUtils.mainTextStyle.copyWith(),
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: CachedImageWidget(
                                url: _controller.yourFriends[i].avatarImage,
                              ),
                            ),
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
