// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:no_name_app/controller/account_controller.dart';
import 'package:no_name_app/controller/passcode_controller.dart';
import 'package:no_name_app/utils/fonts.dart';

// ignore: must_be_immutable
class NumberKeyBoard extends StatelessWidget {
  NumberKeyBoard({required this.controller, Key? key}) : super(key: key);
  final PassCodeController controller;
  Widget keyboardElement(Widget title) {
    return SizedBox(
      height: 30,
      width: 50,
      child: Center(child: title),
    );
  }

  List<String> keyboardItem = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    ' ',
    '0',
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        for (int i = 0; i < keyboardItem.length; i++)
          keyboardElement(FlatButton(
              onPressed: () {
                controller.onTapKeyBoard(keyboardItem[i]);
              },
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    keyboardItem[i],
                    style: FontUtils.mainTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ))),
        keyboardElement(IconButton(
            onPressed: () {
              controller.onTapKeyBoard('delete');
            },
            icon: const Icon(Icons.backspace)))
      ],
    );
  }
}
