import 'package:flutter/material.dart';

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
        children: [icon, Text(title)],
      ),
      height: 30,
      width: 200,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
