import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/routes/app_router.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddExpenseController(),
      builder: (AddExpenseController _controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    _controller.onSave();
                  },
                  icon: const Icon(Icons.check))
            ],
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                ),
                Container(
                    width: 200,
                    child: TextFormField(
                      controller: _controller.descriptionController,
                      decoration:
                          InputDecoration(hintText: 'Enter a description',hintStyle: FontUtils.mainTextStyle.copyWith()),
                    )),
                Container(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller.valueController,
                      decoration: InputDecoration(
                          hintText: '0.00',
                          hintStyle: FontUtils.mainTextStyle.copyWith()),
                    )),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Text('Paid by',
                          style: FontUtils.mainTextStyle.copyWith()),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.CHOOSE_WHO_PAID);
                          },
                          child: Text('You',
                              style: FontUtils.mainTextStyle.copyWith())),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Text(
                        'Split',
                        style: FontUtils.mainTextStyle.copyWith(),
                      ),
                      TextButton(
                          onPressed: () {
                            if (_controller.valueController.text != "") {
                              Get.toNamed(Routes.CHOOSE_OPTION_SPLIT);
                            } else {
                              Get.defaultDialog(
                                  title: "",
                                  middleText:
                                      "You must have enter value of this expenses first");
                            }
                          },
                          child: Text('equally',
                              style: FontUtils.mainTextStyle.copyWith())),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
