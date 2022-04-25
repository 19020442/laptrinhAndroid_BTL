import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';

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
                    icon: Icon(Icons.save))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  FlatButton(
                      onPressed: () {
                        _controller.switchMultiChoiceMode();
                      },
                      child: const Text('Multi choice')),
                  for (int i = 0; i < _controller.membersOfExpense.length; i++)
                    if (!_controller.isMultiChoiceMode)
                      ListTile(
                        onTap: () {
                          _controller.onChoosePayer(
                              _controller.membersOfExpense[i], i);
                        },
                        leading: Text('$i'),
                        title: Text(_controller.membersOfExpense[i].name!),
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
                                          leading: Text('$i'),
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
