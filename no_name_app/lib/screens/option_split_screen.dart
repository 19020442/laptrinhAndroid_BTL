import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';

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
                        color: _controller.totalPercentCurrently != 100.0
                            ? Colors.red[100]
                            : Colors.green[100],
                        height: 50,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                                '${_controller.totalPercentCurrently}% trên 100%',
                                style: FontUtils.mainTextStyle.copyWith()),
                            Text(
                              '${(100 - _controller.totalPercentCurrently)}% còn lại',
                              style: FontUtils.mainTextStyle.copyWith(),
                            )
                          ],
                        ),
                      )
                    : null,
                appBar: AppBar(
                  actions: [
                    IconButton(
                        onPressed: () {
                          _controller.formKeySplitPercent.currentState!.save();
                          if (_controller.isOnSplitUnequallyMode &&
                              _controller.totalPercentCurrently == 100.0) {
                            Get.back();
                          } else if (!_controller.isOnSplitUnequallyMode) {
                            Get.back();
                          }
                        },
                        icon: const Icon(Icons.check))
                  ],
                  title: Text(
                    'Chia hóa đơn',
                    style: FontUtils.mainTextStyle.copyWith(),
                  ),
                  bottom: TabBar(
                    labelStyle: FontUtils.mainTextStyle.copyWith(),
                    onTap: (index) {
                      _controller.swtichToUnequallyOption(index);
                    },
                    tabs: const [
                      Tab(
                        text: "Chia đều",
                      ),
                      Tab(
                        text: "Theo phần trăm",
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
                                              leading: Container(
                                                height: 50,
                                                width: 50,
                                                child: CachedImageWidget(
                                                  url: _controller
                                                      .membersOfExpense[i]
                                                      .avatarImage,
                                                ),
                                              ),
                                              title: Text(
                                                _controller
                                                    .membersOfExpense[i].name!,
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                              ),
                                              subtitle: Text(
                                                (double.parse(_controller
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
                                                            .text) /
                                                        100)
                                                    .toString(),
                                                style: FontUtils.mainTextStyle
                                                    .copyWith(),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: TextFormField(
                                              style: FontUtils.mainTextStyle
                                                  .copyWith(),
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
