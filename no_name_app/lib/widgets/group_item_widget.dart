import 'package:flutter/material.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

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
                    image: itemData.imageGroup == ""
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: ExactAssetImage(itemData.typeGroup == 'Trip'
                                ? ImageUtils.deafaultGroupTripImage
                                : itemData.typeGroup == 'Home'
                                    ? ImageUtils.deafaultGroupHomeImage
                                    : ImageUtils.deafaultGroupOtherImage))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(itemData.imageGroup!)),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
              )),
          Flexible(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  itemData.nameGroup!,
                  style: FontUtils.mainTextStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
