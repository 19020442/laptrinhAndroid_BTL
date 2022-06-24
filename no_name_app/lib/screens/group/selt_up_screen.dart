import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class SettleUpScreen extends StatelessWidget {
  const SettleUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MyGroupController(),
      builder: (MyGroupController _controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Chọn một bạn để thanh toán',
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
                  if (_controller.status[i]['amount'] > 0)
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.RECORD_PAYMENT_SCREEN, arguments: {
                          'payer': _controller.status[i],
                          'group-model': _controller.currentGroup,
                        });
                      },
                      leading: Container(
                          height: 50,
                          width: 50,
                          child: CachedImageWidget(
                              url: _controller.status[i]['avatar'])),
                      title: Text(
                        _controller.status[i]['name'],
                        style: FontUtils.mainTextStyle
                            .copyWith(color: Colors.black),
                      ),
                      trailing: Text(
                        _controller.status[i]['amount'].toInt().toString() + " vnđ",
                        style: FontUtils.mainTextStyle
                            .copyWith(color: Colors.black),
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
