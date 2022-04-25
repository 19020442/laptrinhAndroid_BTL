import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/routes/app_router.dart';
import 'package:no_name_app/routes/routes.dart';

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
                  icon: const Icon(Icons.save))
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
                          InputDecoration(hintText: 'Enter a description'),
                    )),
                Container(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _controller.valueController,
                      decoration: InputDecoration(hintText: '0.00',),
                    )),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Text('Paid by'),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.CHOOSE_WHO_PAID);
                          },
                          child: Text('You')),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      Text('Split'),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.CHOOSE_OPTION_SPLIT);
                          },
                          child: Text('equally')),
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
