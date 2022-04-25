import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:no_name_app/controller/my_group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';

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
              Container(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  child: Column(
                    children: [
                      Flexible(
                          flex: 2,
                          child: Container(
                            color: Colors.amber,
                          )),
                      Flexible(
                          flex: 9,
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.currentGroup.nameGroup!,
                                  style: FontUtils.mainTextStyle.copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text("Status"),
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i < _controller.status.length;
                                        i++)
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(_controller.status[i]
                                                ['name'] +
                                            " ownes you " +
                                            _controller.status[i]['amount']
                                                .toString() +
                                            " VND"),
                                      )
                                  ],
                                ),
                                const Text("Members"),
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i < _controller.listMember.length;
                                        i++)
                                      ListTile(
                                        leading: Text(i.toString()),
                                        title: Text(
                                            _controller.listMember[i].name!),
                                      )
                                  ],
                                ),
                                const Text('Expenses'),
                                Column(
                                  children: [
                                    for (int i = 0;
                                        i < _controller.listExpenses.length;
                                        i++)
                                      ListTile(
                                        leading: Text(i.toString()),
                                        title: Text(
                                            _controller.listExpenses[i].name),
                                      )
                                  ],
                                )
                              ],
                            ),
                          ))
                    ],
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
                    child: addWidget('Add Expense')),
              ),
              Positioned(
                left: 35,
                bottom: 25,
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.ADD_MEMBER_OF_GROUPS, arguments: {
                        'group-model': _controller.currentGroup,
                        'user-model': _controller.userModel
                      });
                    },
                    child: addWidget('Add Member')),
              )
            ],
          ),
        );
      },
    );
  }
}
