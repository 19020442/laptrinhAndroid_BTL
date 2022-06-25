import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/activity_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
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
                style: FontUtils.mainTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff59ba85)),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: (_controller.listActivity.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage(ImageUtils.noActImage),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  'Các hoạt động của bạn sẽ được ghi lại tại đây!',
                                  textAlign: TextAlign.center,
                                  style: FontUtils.mainTextStyle
                                      .copyWith(color: Colors.grey[500]),
                                ),
                              ),
                              SizedBox(
                                height: 200,
                              )
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < _controller.listActivity.length;
                                  i++)
                                TextButton(
                                    onPressed: () {
                                      if (_controller.listActivity[i].type ==
                                          TypeOfActivity.CreateNewGroup) {
                                        Get.toNamed(Routes.MY_GROUP_SCREEN,
                                            arguments: {
                                              'group-model': GroupModel.fromMap(
                                                  _controller
                                                      .listActivity[i].useCase),
                                              'user-model':
                                                  _controller.userModel
                                            });
                                      }
                                    },
                                    child: ActivityWiget(
                                        activityModel:
                                            _controller.listActivity[i]))
                            ],
                          ),
                        ))
            ]),
          );
        });
  }
}
