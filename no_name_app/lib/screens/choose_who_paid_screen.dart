import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class ChooseWhoPaidScreen extends StatelessWidget {
  const ChooseWhoPaidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddExpenseController(),
        builder: (AddExpenseController _controller) {
          return SizedBox(
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  width: 300,
                  height: 50,
                  child: Text(
                    'Chọn người trả',
                    style: FontUtils.mainTextStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    for (int i = 0;
                        i < _controller.membersOfExpense.length;
                        i++)
                      if (!_controller.isMultiChoiceMode)
                        Container(
                          width: 300,
                          height: 60,
                          child: Center(
                            child: ListTile(
                              onTap: () {
                                _controller.onChoosePayer(
                                    _controller.membersOfExpense[i], i);
                              },
                              trailing: _controller
                                      .isTapped(_controller.membersOfExpense[i])
                                  ? Icon(Icons.check)
                                  : Text(''),
                              leading: Container(
                                  height: 50,
                                  width: 50,
                                  child: CachedImageWidget(
                                    url: _controller
                                        .membersOfExpense[i].avatarImage,
                                  )),
                              title: Text(
                                _controller.membersOfExpense[i].name!,
                                style: FontUtils.mainTextStyle.copyWith(),
                              ),
                            ),
                          ),
                        ),
                    if (_controller.isMultiChoiceMode)
                      Form(
                          key: _controller.formKey,
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < _controller.membersOfExpense.length;
                                  i++)
                                Container(
                                    width: 300,
                                    height: 70,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 60,
                                          child: Center(
                                            child: ListTile(
                                              onTap: () {},
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
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: TextFormField(
                                          style: FontUtils.mainTextStyle
                                              .copyWith(),
                                          key: Key(i.toString()),
                                          onSaved: (value) {
                                            _controller
                                                .onSaveSetAmountPerMember(
                                                    i,
                                                    _controller
                                                        .membersOfExpense[i],
                                                    value);
                                          },
                                        )),
                                      ],
                                    )),
                            ],
                          )),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      _controller.switchMultiChoiceMode();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(15),
                          color: _controller.isMultiChoiceMode
                              ? Colors.blue
                              : Colors.white),
                      child: Center(
                        child: Text(
                          'Multi choice',
                          style: FontUtils.mainTextStyle.copyWith(
                              color: _controller.isMultiChoiceMode
                                  ? Colors.white
                                  : Colors.blue),
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }
}
