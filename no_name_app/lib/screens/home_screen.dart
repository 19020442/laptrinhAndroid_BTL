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
                      'Groups',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 0
                              ? Colors.blue
                              : Colors.black,
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
                      'Friends',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 1
                              ? Colors.blue
                              : Colors.black,
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
                      'Activity',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 2
                              ? Colors.blue
                              : Colors.black,
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
                      'Account',
                      style: FontUtils.mainTextStyle.copyWith(
                          color: _controller.currentIndex == 3
                              ? Colors.blue
                              : Colors.black,
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
    behavior: HitTestBehavior.opaque,
    child: Container(
      height: 50,
      child: Column(
        children: [
          SizedBox(height: 30, width: 30, child: icon),
          if (child != null) child
        ],
      ),
    ),
  );
}
