import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';

class SettleUpScreen extends StatelessWidget {
  const SettleUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyGroupController(),
      builder: (MyGroupController _controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Select a balance to settle up',
              style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
                child: Column(
              // for (int i = 0 ; i < _controller.sta)
              children: [
                for (int i = 0; i < _controller.status.length; i++)
                  ListTile(
                    onTap: () {
                      Get.toNamed(Routes.RECORD_PAYMENT_SCREEN, arguments: {
                        'payer': _controller.status[i],
                        'group-model': _controller.currentGroup,
                      });
                    },
                    leading: CircleAvatar(),
                    title: Text(
                      _controller.status[i]['name'],
                      style:
                          FontUtils.mainTextStyle.copyWith(color: Colors.black),
                    ),
                    trailing: Text(
                      _controller.status[i]['amount'].toString(),
                      style:
                          FontUtils.mainTextStyle.copyWith(color: Colors.black),
                    ),
                  )
              ],
            )),
          ),
        );
      },
    );
  }
}
