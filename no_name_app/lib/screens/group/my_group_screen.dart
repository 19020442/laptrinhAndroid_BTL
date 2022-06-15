import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/models/expense_model.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class MyGroupScreen extends StatelessWidget {
  const MyGroupScreen({Key? key}) : super(key: key);
  Widget addWidget(String add) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ], color: Colors.blue, borderRadius: BorderRadius.circular(25)),
      height: 50,
      width: 150,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            add,
            style: FontUtils.mainTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GetBuilder(
      init: MyGroupController(),
      builder: (MyGroupController _controller) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 2,
                          child: SizedBox(
                              width: double.infinity,
                              child: _controller.currentGroup.imageGroup == ""
                                  ? Image.asset(
                                      _controller.currentGroup.typeGroup ==
                                              'Trip'
                                          ? ImageUtils.deafaultGroupTripImage
                                          : _controller
                                                      .currentGroup.typeGroup ==
                                                  'Home'
                                              ? ImageUtils
                                                  .deafaultGroupHomeImage
                                              : ImageUtils
                                                  .deafaultGroupOtherImage,
                                      fit: BoxFit.fitWidth,
                                      color: Colors.white.withOpacity(0.1),
                                      colorBlendMode: BlendMode.difference)
                                  : Image.network(
                                      _controller.currentGroup.imageGroup!,
                                      fit: BoxFit.fitWidth,
                                      color: Colors.white.withOpacity(0.1),
                                      colorBlendMode: BlendMode.difference))),
                      Flexible(
                          flex: 9,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 60),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.currentGroup.nameGroup!,
                                    style: FontUtils.mainTextStyle.copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Card(
                                            color: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                    Routes.SETTLE_UP_SCREEN);
                                              },
                                              child: Container(
                                                // color: Colors.blue,
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    'Thanh toán',
                                                    style: FontUtils
                                                        .mainTextStyle
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                _controller
                                                    .openBalances(context);
                                              },
                                              child: Container(
                                                // color: Colors.blue,
                                                width: 150,
                                                child: Center(
                                                  child: Text(
                                                    'Chi tiết',
                                                    style: FontUtils
                                                        .mainTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 5,
                                            child: Container(
                                              // color: Colors.blue,
                                              width: 150,
                                              child: TextButton(
                                                onPressed: () {
                                                  _controller
                                                      .openWhiteBoard(context);
                                                },
                                                child: Center(
                                                  child: Text(
                                                    'Ghi chú',
                                                    style: FontUtils
                                                        .mainTextStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // const Text('Expenses'),
                                  _controller.isLoading
                                      ? const CircularProgressIndicator()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          child: Column(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      _controller
                                                          .listExpenses.length;
                                                  i++)
                                                TextButton(
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        Routes.EXPENSE_SCREEN,
                                                        arguments: {
                                                          'expense-model':
                                                              _controller
                                                                  .listExpenses[i],
                                                          'group-model':
                                                              _controller
                                                                  .currentGroup
                                                        });
                                                  },
                                                  child: ExpenseWidget(
                                                    expense: _controller
                                                        .listExpenses[i],
                                                    amount: _controller
                                                        .listState[i]
                                                        .toString(),
                                                  ),
                                                )
                                            ],
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ))
                    ],
                  )),
              Positioned(
                  right: 20,
                  top: 50,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.GROUP_SETTING);
                    },
                    child: SvgPicture.asset(
                      IconUtils.icSetting,
                      height: 30,
                      width: 30,
                    ),
                  )),
              Positioned(
                  left: 20,
                  top: 40,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                      size: 40,
                    ),
                  )),
              Positioned(
                right: 35,
                bottom: 25,
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ADD_EXPENSE_SCREEN, arguments: {
                        'group-model': _controller.currentGroup,
                        'user-model': _controller.userModel
                      });
                    },
                    child: addWidget('Thêm hóa đơn')),
              ),
              Positioned(
                  top: deviceSize.height * 0.13,
                  left: 30,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.white),
                      borderRadius: BorderRadius.circular(15),
                      image: _controller.currentGroup.imageGroup == ""
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: ExactAssetImage(_controller
                                          .currentGroup.typeGroup ==
                                      'Trip'
                                  ? ImageUtils.deafaultGroupTripImage
                                  : _controller.currentGroup.typeGroup == 'Home'
                                      ? ImageUtils.deafaultGroupHomeImage
                                      : ImageUtils.deafaultGroupOtherImage))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  _controller.currentGroup.imageGroup!)),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({required this.expense, required this.amount, Key? key})
      : super(key: key);
  final ExpenseModel expense;
  final String amount;
  @override
  Widget build(BuildContext context) {
    return expense.type == 'new'
        ? SizedBox(
            height: 55,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Th' +
                        expense.dateCreate.month.toString() +
                        '\n ${expense.dateCreate.day}',
                    style: FontUtils.mainTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  flex: 12,
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(
                        IconUtils.icExpense,
                      ),
                    ),
                    title: Text(
                      expense.name,
                      style: FontUtils.mainTextStyle
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    trailing: amount[0] != '-'
                        ? Text(
                            'You lent \n' + amount + ' vnđ',
                            style: FontUtils.mainTextStyle
                                .copyWith(color: Colors.blue),
                            textAlign: TextAlign.end,
                          )
                        : Text(
                            'You borrowed \n ${-double.parse(amount)} vnđ',
                            style: FontUtils.mainTextStyle
                                .copyWith(color: Colors.red),
                            textAlign: TextAlign.end,
                          ),
                    subtitle: Text(
                      'Giá trị: ' + expense.value + ' đ',
                      style: FontUtils.mainTextStyle.copyWith(),
                    ),
                  ),
                )
              ],
            ),
          )
        : SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    'Th' +
                        expense.dateCreate.month.toString() +
                        '\n ${expense.dateCreate.day}',
                    style: FontUtils.mainTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  flex: 1,
                ),
                Flexible(
                    flex: 12,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          // color: Colors.black,
                          image: DecorationImage(
                            image: AssetImage(
                              ImageUtils.recordEx,
                            ),
                            // fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        expense.name,
                        style: FontUtils.mainTextStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ))
              ],
            ),
          );
  }
}
