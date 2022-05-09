import 'package:flutter/material.dart';
import 'package:no_name_app/utils/fonts.dart';

class TypeOfGroup extends StatelessWidget {
  const TypeOfGroup(
      {Key? key,
      required this.icon,
      required this.title,
      required this.isChoosen})
      : super(key: key);
  final IconData icon;
  final String title;
  final bool isChoosen;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isChoosen ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: isChoosen ? Colors.white : Colors.blue,
          ),
          Text(
            title,
            style: FontUtils.mainTextStyle
                .copyWith(color: isChoosen ? Colors.white : Colors.blue),
          ),
        ],
      ),
    );
  }
}
