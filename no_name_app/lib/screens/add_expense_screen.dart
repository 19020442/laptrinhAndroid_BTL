import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/routes/app_router.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddExpenseController(),
      builder: (AddExpenseController _controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Thêm hóa đơn mới',
              style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    _controller.onSave();
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Center(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(left: 30),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.CHOOSE_CATEGORY_SCREEN);
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            // IconUtils.icExpense
                                            IconUtils
                                                .icExpenseList[_controller
                                                    .cateIndexSelected]
                                                .values
                                                .elementAt(0))),
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                  width: 200,
                                  child: TextFormField(
                                    style: FontUtils.mainTextStyle.copyWith(),
                                    focusNode: _controller.initFocus,
                                    controller:
                                        _controller.descriptionController,
                                    decoration: InputDecoration(
                                        hintText: 'Nhập tên hóa đơn',
                                        hintStyle:
                                            FontUtils.mainTextStyle.copyWith()),
                                  )),
                              Container(
                                  width: 200,
                                  child: TextFormField(
                                    style: FontUtils.mainTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _controller.valueController,
                                    decoration: InputDecoration(
                                        hintText: '0.00',
                                        hintStyle: FontUtils.mainTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                                color: Colors.grey[500])),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Text('Người thanh toán',
                                style: FontUtils.mainTextStyle.copyWith()),
                            TextButton(
                                onPressed: () {
                                  if (_controller.valueController.text != "") {
                                    _controller.openChoosePayer(context);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Dialog(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              child: Text(
                                                "Bạn cần nhập giá trị hóa đơn trước",
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  // Get.toNamed(Routes.CHOOSE_WHO_PAID);
                                },
                                child: Text(_controller.payers,
                                    style: FontUtils.mainTextStyle.copyWith())),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: Row(
                          children: [
                            Text(
                              'Chia',
                              style: FontUtils.mainTextStyle.copyWith(),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_controller.valueController.text != "") {
                                    // Get.toNamed(Routes.CHOOSE_OPTION_SPLIT);
                                    _controller.openAdjustSplit(context);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext ctx) {
                                          return Dialog(
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 50,
                                              child: Text(
                                                "Bạn cần nhập giá trị hóa đơn trước",
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                },
                                child: Text(_controller.splitText,
                                    style: FontUtils.mainTextStyle.copyWith())),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ))),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                _controller.openDatePicker(context);
                              },
                              icon: const Icon(Icons.calendar_today)),
                          IconButton(
                              onPressed: () {
                                _controller.openNote(context);
                              },
                              icon: const Icon(Icons.note_alt_outlined))
                        ],
                      ),
                      // width: double.infinity,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
