import 'package:flutter/material.dart';

class TypeOfGroup extends StatelessWidget {
  const TypeOfGroup({Key? key, required this.icon, required this.title})
      : super(key: key);
  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(title),
        ],
      ),
    );
  }
}
