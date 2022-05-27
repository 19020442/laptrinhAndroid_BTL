import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class GroupSettingScreen extends StatelessWidget {
  const GroupSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyGroupController(),
      builder: (MyGroupController _controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Group settings',
              style:
                  FontUtils.mainTextStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            image: _controller.currentGroup.imageGroup == ""
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ExactAssetImage(
                                        ImageUtils.defaultGroupImage))
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        _controller.currentGroup.imageGroup!)),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      Text(
                        _controller.currentGroup.nameGroup!,
                        style: FontUtils.mainTextStyle.copyWith(),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(IconUtils.icEdit),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Text(
                  'Group members',
                  style: FontUtils.mainTextStyle.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.ADD_MEMBER_OF_GROUPS, arguments: {
                      'list-member': _controller.listMember,
                      'group-model': _controller.currentGroup,
                      'user-model': _controller.userModel
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.group_add_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Add people to group',
                          style: FontUtils.mainTextStyle.copyWith(),
                        )
                      ],
                    ),
                  ),
                ),
                for (int i = 0; i < _controller.listMember.length; i++)
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 20,
                    ),
                    title: Text(
                      _controller.listMember[i].name!,
                      style: FontUtils.mainTextStyle
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(_controller.listMember[i].email!,
                        style: FontUtils.mainTextStyle.copyWith()),
                  ),
                GestureDetector(
                  onTap: () {
                    _controller.leaveGroup();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 50,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Leave group',
                          style: FontUtils.mainTextStyle.copyWith(),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _controller.deleteGroup();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          IconUtils.icDelete,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          'Delete group',
                          style: FontUtils.mainTextStyle.copyWith(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
