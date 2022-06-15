import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/cached_image.dart';

class ActivityWiget extends StatelessWidget {
  const ActivityWiget({required this.activityModel, Key? key})
      : super(key: key);
  final ActivityModel activityModel;

  String getDayDiff(DateTime time) {
    final date2 = DateTime.now();

    // var type = 'ngày trước';
    var difference = date2.difference(time).inDays;
    var day = difference.toString() + " ngày trước";
    switch (difference) {
      case 0:
        day = "Hôm nay";
        break;
      case 1:
        day = "Hôm qua";
        break;
      case 2:
        day = "Hôm kia";
        break;
    }
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: Stack(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    child: activityModel.type == TypeOfActivity.CommentOnExpense
                        ? SvgPicture.asset(IconUtils.icCommentActivity)
                        : activityModel.useCase['Image'] == ""
                            ? (activityModel.useCase['Type'] == "Home"
                                ? Image(
                                    image: AssetImage(
                                        ImageUtils.deafaultGroupHomeImage),
                                  )
                                : activityModel.useCase['Type'] == "Trip"
                                    ? Image(
                                        image: AssetImage(
                                            ImageUtils.deafaultGroupTripImage),
                                      )
                                    : Image(
                                        image: AssetImage(
                                            ImageUtils.deafaultGroupOtherImage),
                                      ))
                            : CachedImageWidget(
                                url: activityModel.useCase['Image'])),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage:
                          NetworkImage(activityModel.actor!.avatarImage!),
                    ))
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activityModel.type == TypeOfActivity.CreateNewGroup)
                Text(
                  '${activityModel.actor!.name} đã tạo nhóm "${activityModel.useCase['Name']}"',
                  style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
                ),
              if (activityModel.type == TypeOfActivity.DeleteGroup)
                Text(
                  '${activityModel.actor!.name} đã xóa nhóm "${activityModel.useCase['Name']}"',
                  style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
                ),
              if (activityModel.type == TypeOfActivity.LeaveGroup)
                Text(
                  '${activityModel.actor!.name} đã rời nhóm "${activityModel.useCase['Name']}"',
                  style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
                ),
              if (activityModel.type == TypeOfActivity.CommentOnExpense)
                Text(
                  '${activityModel.actor!.name} đã bình luận trong "${activityModel.zone['Name']}"',
                  style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
                ),
              Text(
                '${activityModel.timeCreate!.hour}:${activityModel.timeCreate!.minute}, ${getDayDiff(activityModel.timeCreate!)}',
                style: FontUtils.mainTextStyle
                    .copyWith(fontSize: 14, color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
