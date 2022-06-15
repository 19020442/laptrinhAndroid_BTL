import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/activity_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/activity_widget.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ActivityController(),
        builder: (ActivityController _controller) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 75,
              ),
              Text(
                'Hoạt động',
                style: FontUtils.mainTextStyle
                    .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < _controller.listActivity.length; i++)
                      TextButton(
                          onPressed: () {
                            if (_controller.listActivity[i].type ==
                                TypeOfActivity.CreateNewGroup) {
                              Get.toNamed(Routes.MY_GROUP_SCREEN, arguments: {
                                'group-model': GroupModel.fromMap(
                                    _controller.listActivity[i].useCase),
                                'user-model': _controller.userModel
                              });
                            }
                          },
                          child: ActivityWiget(
                              activityModel: _controller.listActivity[i]))
                  ],
                ),
              ))
            ]),
          );
        });
  }
}
