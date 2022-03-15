import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (GroupController _controller) {
        return Center(
          // padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if (_controller.listGroups.isEmpty)
              Image.asset(
                ImageUtils.noGroupImage,
                height: 200,
                width: 200,
              ),
            if (_controller.listGroups.isEmpty)
              Text(
                'Bạn chưa có nhóm để hiển thị',
                style: FontUtils.mainTextStyle.copyWith(),
              )
          ]),
        );
      },
      init: GroupController(),
    );
  }
}
