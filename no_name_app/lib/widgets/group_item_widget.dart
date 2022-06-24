import 'package:flutter/material.dart';
import 'package:no_name_app/models/group_model.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class GroupItemWidget extends StatelessWidget {
  const GroupItemWidget({Key? key, required this.itemData, required this.ovr})
      : super(key: key);
  final GroupModel itemData;
  final double ovr;
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
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemData.nameGroup!,
                      style: FontUtils.mainTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          // color: itemData.typeGroup == 'Other'
                          //     ? const Color(0xffd27979)
                          //     : itemData.typeGroup == 'Trip'
                          //         ? Colors.blue[300]
                          //         : itemData.typeGroup == 'Home'
                          //             ? Colors.red[300]
                          //             : Colors.blue
                                      ),
                    ),
                    if (ovr != 0)
                      Text(
                        ovr > 0
                            ? 'Bạn đang cho mượn ${ovr.toInt()} vnđ'
                            : 'Bạn đang mượn ${(ovr * -1).toInt()} vnđ',
                        textAlign: TextAlign.start,
                        style: FontUtils.mainTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ovr > 0 ? Colors.blue : Colors.red[300]),
                      )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
