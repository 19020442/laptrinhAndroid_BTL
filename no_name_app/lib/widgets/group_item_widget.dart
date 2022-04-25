import 'package:flutter/material.dart';
import 'package:no_name_app/models/group_model.dart';

class GroupItemWidget extends StatelessWidget {
  const GroupItemWidget({Key? key, required this.itemData}) : super(key: key);
  final GroupModel itemData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                height: 60,
                width: 60,
              )),
          Flexible(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [Text(itemData.nameGroup!)],
            ),
          ))
        ],
      ),
    );
  }
}
