import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:no_name_app/controller/home_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController _controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: _controller.listPages[_controller.currentIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 0.2)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bottomSheetItem(
                    icon: SvgPicture.asset(
                      _controller.currentIndex == 0
                          ? IconUtils.icGroupSelected
                          : IconUtils.icGroup,
                    ),
                    child: Text(
                      'Nhóm',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 0
                              ? Colors.blue
                              : Colors.grey,
                          fontWeight: _controller.currentIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    onTap: () {
                      _controller.updateIndex(0);
                    },
                  ),
                  bottomSheetItem(
                    child: Text(
                      'Bạn bè',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 1
                              ? Color(0xffED834E)
                              : Colors.grey,
                          fontWeight: _controller.currentIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    icon: SvgPicture.asset(_controller.currentIndex == 1
                        ? IconUtils.icFriendSelected
                        : IconUtils.icFriend),
                    onTap: () {
                      _controller.updateIndex(1);
                    },
                  ),
                  bottomSheetItem(
                    child: Text(
                      'Hoạt động',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 2
                              ? Color(0xff59ba85)
                              : Colors.grey,
                          fontWeight: _controller.currentIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    icon: SvgPicture.asset(_controller.currentIndex == 2
                        ? IconUtils.icActivityListSelected
                        : IconUtils.icActivityList),
                    onTap: () {
                      _controller.updateIndex(2);
                    },
                  ),
                  bottomSheetItem(
                    child: Text(
                      'Tài khoản',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 3
                              ?Color(0xff95a86a)
                              : Colors.grey,
                          fontWeight: _controller.currentIndex == 3
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    icon: SvgPicture.asset(_controller.currentIndex == 3
                        ? IconUtils.icProfileSelected
                        : IconUtils.icProfile),
                    onTap: () {
                      _controller.updateIndex(3);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget bottomSheetItem({
  Widget? icon,
  Function()? onTap,
  int? index,
  int? currentIndex,
  Widget? child,
}) {
  return GestureDetector(
    onTap: onTap,
    // behavior: HitTestBehavior.,
    child: SizedBox(
      height: 50,
      child: Column(
        children: [
          SizedBox(height: 20, width: 20, child: icon),
          if (child != null) child
        ],
      ),
    ),
  );
}
