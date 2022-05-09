import 'package:flutter/material.dart';
import 'package:no_name_app/utils/fonts.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Icon icon;
  AddButton({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [icon, Text(title, style: FontUtils.mainTextStyle.copyWith(
          color: Colors.white
        ),)],
      ),
      height: 30,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
