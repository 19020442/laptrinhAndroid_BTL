import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/group_item_widget.dart';
import 'package:no_name_app/widgets/new_group_button.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GroupController(),
      builder: (GroupController _controller) {
        return Center(
          // padding: const EdgeInsets.all(15),
          child: _controller.listGroups.isEmpty
              ? Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Image.asset(
                    ImageUtils.noGroupImage,
                    height: 200,
                    width: 200,
                  ),
                  Text(
                    'Bạn chưa có nhóm để hiển thị',
                    style: FontUtils.mainTextStyle.copyWith(),
                  ),
                  GestureDetector(
                      onTap: _controller.startCreateNewGroup,
                      child: AddButton(
                        icon: Icon(Icons.group_add),
                        title: 'Start new group',
                      ))
                ])
              : Column(
                  children: [
                    for (int i = 0; i < _controller.listGroups.length; i++)
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.MY_GROUP_SCREEN, arguments: {
                            'group-model': _controller.listGroups[i],
                            'user-model': _controller.userModel
                          });
                        },
                        child: GroupItemWidget(
                            itemData: _controller.listGroups[i]),
                      ),
                    GestureDetector(
                        onTap: _controller.startCreateNewGroup,
                        child: AddButton(
                          icon: Icon(Icons.group_add),
                          title: 'Start new group',
                        ))
                  ],
                ),
        );
      },
    );
  }
}
