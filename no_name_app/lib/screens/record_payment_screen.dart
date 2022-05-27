import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/record_payment_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

class RecordPaymentScreen extends StatelessWidget {
  const RecordPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RecordPaymentController(),
        builder: (RecordPaymentController _controller) {
          return Scaffold(
            appBar: AppBar(
              
              leading: IconButton(icon: Icon(Icons.navigate_before, color: Colors.black), onPressed: () {
                Get.back();
              },),
              
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Record payment',
                style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
              ),
              actions: [
                IconButton(onPressed: (){
                  _controller.onSave();
                }, icon: Icon(Icons.check, color: Colors.black,))
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 150,
                      child: Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 50,
                          ),
                          CircleAvatar(),
                        ],
                      )),
                  Text(
                    _controller.payer['name'] + " paid you",
                    style: FontUtils.mainTextStyle.copyWith(),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    child: TextFormField(
                      focusNode: _controller.valueFocus,
                      controller: _controller.valueController,
                      style: FontUtils.mainTextStyle.copyWith(),
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
