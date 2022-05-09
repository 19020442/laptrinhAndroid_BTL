import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

class ChooseWhoPaidScreen extends StatelessWidget {
  const ChooseWhoPaidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: AddExpenseController(),
        builder: (AddExpenseController _controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Who paid'),
              actions: [
                IconButton(
                    onPressed: () {
                      if (_controller.isMultiChoiceMode) {
                        _controller.formKey.currentState!.save();
                      } else {
                        Get.back();
                      }
                    },
                    icon: const Icon(Icons.check))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  for (int i = 0; i < _controller.membersOfExpense.length; i++)
                    if (!_controller.isMultiChoiceMode)
                      Container(
                        width: 400,
                        height: 50,
                        child: ListTile(
                          onTap: () {
                            _controller.onChoosePayer(
                                _controller.membersOfExpense[i], i);
                          },
                          trailing: _controller.isTapped(_controller.membersOfExpense[i]) ? Icon(Icons.check): Text(''),
                          leading: const CircleAvatar(),
                          title: Text(_controller.membersOfExpense[i].name!),
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
                                  width: 400,
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 300,
                                        height: 50,
                                        child: ListTile(
                                          onTap: () {},
                                          leading: const CircleAvatar(),
                                          title: Text(_controller
                                              .membersOfExpense[i].name!),
                                        ),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        key: Key(i.toString()),
                                        onSaved: (value) {
                                          _controller.onSaveSetAmountPerMember(
                                              i,
                                              _controller.membersOfExpense[i],
                                              value);
                                        },
                                      )),
                                    ],
                                  )),
                          ],
                        ))
                ],
              ),
            ),
          );
        });
  }
}
