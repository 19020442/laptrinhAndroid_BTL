import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/models/activity_model.dart';
import 'package:no_name_app/models/user_model.dart';
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

  Widget backgroundWidget(ActivityModel activityModel) {
    if (activityModel.type == TypeOfActivity.CommentOnExpense) {
      return SvgPicture.asset(IconUtils.icCommentActivity);
    }
    if (activityModel.type == TypeOfActivity.AddNewFriend) {
      return SvgPicture.asset(IconUtils.icAddFriendActivity);
    }
    if (activityModel.type == TypeOfActivity.CreateNewGroup ||
        activityModel.type == TypeOfActivity.DeleteGroup ||
        activityModel.type == TypeOfActivity.UpdateNote) {
      if (activityModel.useCase['Image'] == "") {
        if (activityModel.useCase['Type'] == "Home") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupHomeImage),
          );
        } else if (activityModel.useCase['Type'] == "Trip") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupTripImage),
          );
        } else if (activityModel.useCase['Type'] == "Study") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupStudyImage),
          );
        } else {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupOtherImage),
          );
        }
      } else {
        return CachedImageWidget(url: activityModel.useCase['Image']);
      }
    }
    if (activityModel.type == TypeOfActivity.AddIntoGroup) {
      if (activityModel.zone['Image'] == "") {
        if (activityModel.zone['Type'] == "Home") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupHomeImage),
          );
        } else if (activityModel.zone['Type'] == "Trip") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupTripImage),
          );
        } else if (activityModel.zone['Type'] == "Study") {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupStudyImage),
          );
        } else {
          return Image(
            image: AssetImage(ImageUtils.deafaultGroupOtherImage),
          );
        }
      } else {
        return CachedImageWidget(url: activityModel.zone['Image']);
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    UserModel userModel = authController.userModel!;
    return SizedBox(
      height: 60,
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
                    child: backgroundWidget(activityModel)),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activityModel.type == TypeOfActivity.CreateNewGroup)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã tạo nhóm "${activityModel.useCase['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.DeleteGroup)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã xóa nhóm "${activityModel.useCase['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.LeaveGroup)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã rời nhóm "${activityModel.useCase['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.CommentOnExpense)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã bình luận trong "${activityModel.zone['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.AddNewFriend)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} vừa thêm bạn mới',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.AddIntoGroup)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã thêm bạn vào nhóm "${activityModel.zone['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                if (activityModel.type == TypeOfActivity.UpdateNote)
                  Text(
                    '${activityModel.actor!.id != userModel.id ? activityModel.actor!.name : "Bạn"} đã cập nhật ghi chú trong nhóm "${activityModel.useCase['Name']}"',
                    style:
                        FontUtils.mainTextStyle.copyWith(color: Colors.black),
                  ),
                Text(
                  '${activityModel.timeCreate!.hour}:${activityModel.timeCreate!.minute}, ${getDayDiff(activityModel.timeCreate!)}',
                  style: FontUtils.mainTextStyle
                      .copyWith(fontSize: 14, color: Colors.black),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
