import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/utils/image.dart';

class SplitOptionScreen extends StatelessWidget {
  const SplitOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddExpenseController(),
        builder: (AddExpenseController _controller) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                bottomSheet: _controller.isOnSplitUnequallyMode
                    ? Container(
                        height: 50,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                                '${_controller.totalPercentCurrently}% of 100%'),
                            Text(
                                '${(100 - _controller.totalPercentCurrently)}% left')
                          ],
                        ),
                      )
                    : null,
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          _controller.formKeySplitPercent.currentState!.save();
                          Get.back();
                        },
                        icon: SvgPicture.asset(
                          IconUtils.icSave,
                          height: 15,
                          width: 15,
                        ))
                  ],
                  title: Text('Adjust split'),
                  bottom: TabBar(
                    onTap: (index) {
                      _controller.swtichToUnequallyOption(index);
                    },
                    tabs: const [
                      Tab(
                        text: "Equally",
                      ),
                      Tab(
                        text: "By percentages",
                      )
                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    TabBarView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const Center(child: Text('Split Equally')),
                        Stack(
                          children: [
                            Form(
                              key: _controller.formKeySplitPercent,
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i < _controller.membersOfExpense.length;
                                      i++)
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 4,
                                            child: ListTile(
                                              leading: CircleAvatar(),
                                              title: Text(_controller
                                                  .membersOfExpense[i].name!),
                                              subtitle: Text((double.parse(_controller
                                                              .percentMemberController[
                                                                  i]
                                                              .text
                                                              .isEmpty
                                                          ? "0.0"
                                                          : _controller
                                                              .percentMemberController[
                                                                  i]
                                                              .text) *
                                                      double.parse(_controller
                                                          .valueController
                                                          .text))
                                                  .toString()),
                                            ),
                                          ),
                                          Flexible(
                                            child: TextFormField(
                                              // key: UniqueKey(),
                                              onSaved: (value) {
                                                _controller
                                                    .getNeedToPayEachMember();
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _controller
                                                  .percentMemberController[i],
                                              onChanged: (value) {
                                                _controller
                                                    .getTotalPercentCurrently();
                                              },
                                            ),
                                            flex: 1,
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
