import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/friend_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';
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
                      // child:
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     GestureDetector(
                      //       child: SvgPicture.asset(IconUtils.icSearch),
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //   ],
                      // ),
                    ),
                    Divider(),
                    // const Text('You are settled up!'),
                    // if (!_controller.loadingFriendsDone)
                    //   const CircularProgressIndicator(),
                    // if (_controller.loadingFriendsDone)
                    if (_controller.listFriends.isEmpty)
                      Column(
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black),
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(ImageUtils.noFriendImage),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Container(
                            width: 250,
                            child: Text(
                              'Bạn chưa có bạn bè, hãy thêm để thêm màu sắc :D',
                              textAlign: TextAlign.center,
                              style: FontUtils.mainTextStyle
                                  .copyWith(color: Colors.grey[600]),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    for (int i = 0; i < _controller.listFriends.length; i++)
                      ListTile(
                        onTap: () {
                          Get.toNamed(Routes.FRIEND_DETAIL_SCREEN, arguments: {
                            'user-model':
                                _controller.listFriends[i].keys.elementAt(0),
                            'detail':
                                _controller.listFriends[i].values.elementAt(0)
                          });
                        },
                        leading: Container(
                            height: 50,
                            width: 50,
                            child: CachedImageWidget(
                              url: _controller.listFriends[i].keys
                                  .elementAt(0)
                                  .avatarImage!,
                            )),
                        title: Text(
                          _controller.listFriends[i].keys.elementAt(0).name!,
                          style: FontUtils.mainTextStyle.copyWith(),
                        ),
                        trailing: Text(
                          _controller.listFriends[i].values
                                      .elementAt(0)['total'] >
                                  0
                              ? 'Nợ bạn ${_controller.listFriends[i].values.elementAt(0)['total'].toInt()} vnđ'
                              : _controller.listFriends[i].values
                                          .elementAt(0)['total'] ==
                                      0
                                  ? 'OK'
                                  : 'Bạn nợ ${(_controller.listFriends[i].values.elementAt(0)['total'] * -1).toInt()} vnđ',
                          style: FontUtils.mainTextStyle.copyWith(
                              color: _controller.listFriends[i].values
                                          .elementAt(0)['total'] <
                                      0
                                  ? Colors.red[300]
                                  : _controller.listFriends[i].values
                                              .elementAt(0)['total'] ==
                                          0
                                      ? Colors.grey
                                      : Colors.green),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        _controller.startAddNewFriend();
                      },
                      child: AddButton(
                          color: _controller.listFriends.length == 0 ?Colors.white: Color(0xffED834E),
                          fontColor: _controller.listFriends.length == 0 ?  Colors.black :Colors.white,
                          icon:  Icon(
                            Icons.person_add,
                            color: _controller.listFriends.length == 0 ? Colors.black : Colors.white,
                          ),
                          title: 'Thêm bạn mới'),
                    ),
                  ],
                );
        });
  }
}
