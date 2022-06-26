import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/record_payment_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class RecordPaymentScreen extends StatelessWidget {
  const RecordPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RecordPaymentController(),
        builder: (RecordPaymentController _controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.navigate_before, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Record payment',
                style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _controller.onSave();
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.black,
                    ))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 230,
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            child: CachedImageWidget(
                                url: _controller.payer['avatar']),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(
                                  ImageUtils.recordImage,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Container(
                            height: 75,
                            width: 75,
                            child: CachedImageWidget(
                                url: _controller.owner.avatarImage),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _controller.payer['name'] + " sẽ trả bạn",
                    style: FontUtils.mainTextStyle.copyWith(),
                  ),
                  Container(
                    width: 150,
                    child: TextFormField(
                      focusNode: _controller.valueFocus,
                      controller: _controller.valueController,
                      style: FontUtils.mainTextStyle
                          .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
                      // initialValue: '${_controller.payer['amount']}',
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
