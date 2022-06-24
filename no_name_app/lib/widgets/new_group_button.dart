import 'package:flutter/material.dart';
import 'package:no_name_app/utils/fonts.dart';

class AddButton extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  final Color fontColor;
  const AddButton({Key? key, required this.icon, required this.title,  required this.color, required this.fontColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [icon, Text(title, style: FontUtils.mainTextStyle.copyWith(
          color: fontColor,
          fontSize: 15,
          fontWeight: FontWeight.bold
        ),)],
      ),
      height: 45,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(color: fontColor),
          color: color,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
