import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/friend_detail_controller.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/models/user_model.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/screens/group/my_group_screen.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class FriendDetailScreen extends StatelessWidget {
  const FriendDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return GetBuilder(
      init: FriendDetailController(),
      builder: (FriendDetailController _controller) {
        print(_controller.data.toString());
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  children: [
                    Flexible(
                        flex: 2,
                        child: SizedBox(
                            width: double.infinity,
                            child: Image.network(
                                _controller.friend.avatarImage!,
                                fit: BoxFit.fitWidth,
                                color: Colors.white.withOpacity(0.1),
                                colorBlendMode: BlendMode.difference))),
                    Flexible(
                        flex: 9,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 60),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.friend.name!,
                                  style: FontUtils.mainTextStyle.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,

                                  child: Column(
                                    children: [
                                      // Text(
                                      //     _controller.data['total'].toString()),
                                      if (_controller.data['details'].length ==
                                          0)
                                        Text(
                                          'Chúng ta không nợ nhau gì cả',
                                          style: FontUtils.mainTextStyle
                                              .copyWith(),
                                        ),
                                      for (int i = 0;
                                          i <
                                              _controller
                                                  .data['details'].length;
                                          i++)
                                        ListTile(
                                          onTap: () {
                                            Get.toNamed(Routes.MY_GROUP_SCREEN,
                                                arguments: {
                                                  'group-model': GroupModel
                                                      .fromMap(_controller
                                                              .data['details']
                                                          [i]['zone']),
                                                  'user-model': _controller.user
                                                });
                                          },
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                image: _controller.data['details'][i]
                                                            ['zone']['Image'] ==
                                                        ""
                                                    ? DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: ExactAssetImage(_controller.data['details'][i]['zone']['Type'] ==
                                                                'Trip'
                                                            ? ImageUtils
                                                                .deafaultGroupTripImage
                                                            : _controller.data['details'][i]['zone']['Type'] ==
                                                                    'Home'
                                                                ? ImageUtils
                                                                    .deafaultGroupHomeImage
                                                                : ImageUtils
                                                                    .deafaultGroupOtherImage))
                                                    : DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(_controller.data['details'][i]['zone']['Image'])),
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(5)),
                                          ),
                                          title: Text(
                                            _controller.data['details'][i]
                                                ['zone']['Name'],
                                            style: FontUtils.mainTextStyle
                                                .copyWith(),
                                          ),
                                          trailing: Text(
                                            _controller.data['details'][i]
                                                        ['amount'] >
                                                    0
                                                ? 'Nợ bạn ${_controller.data['details'][i]['amount'].toInt()} vnđ'
                                                : _controller.data['details'][i]
                                                            ['amount'] ==
                                                        0
                                                    ? 'OK'
                                                    : 'Bạn nợ ${(_controller.data['details'][i]['amount'] * -1).toInt()} vnđ',
                                            style: FontUtils.mainTextStyle
                                                .copyWith(
                                                    color: _controller.data[
                                                                    'details']
                                                                [i]['amount'] <
                                                            0
                                                        ? Colors.red[300]
                                                        : _controller.data['details']
                                                                        [i][
                                                                    'amount'] ==
                                                                0
                                                            ? Colors.grey
                                                            : Colors.green),
                                          ),
                                        )
                                    ],
                                  ),
                                  // child: ExpenseWidget(amount: ,),
                                ) // Text(_controller.data.toString())
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Positioned(
                  right: 20,
                  top: 50,
                  child: GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.GROUP_SETTING);
                    },
                    child: SvgPicture.asset(
                      IconUtils.icSetting,
                      height: 30,
                      width: 30,
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 40,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                      size: 40,
                    ),
                  )),
              Positioned(
                  top: deviceSize.height * 0.13,
                  left: 30,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_controller.friend.avatarImage!)),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
