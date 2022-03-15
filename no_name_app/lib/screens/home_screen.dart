import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/auth_controller.dart';
import 'package:no_name_app/controller/home_controller.dart';
import 'package:no_name_app/screens/account_screen.dart';
import 'package:no_name_app/screens/friends_screen.dart';
import 'package:no_name_app/screens/groups_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController _controller) {
          // print(_controller.userModel.name);
          return Scaffold(
            appBar: AppBar(
                // bottom: TabBar(tabs: [
                //   Tab(text: 'Groups',),
                //   Tab(text: 'Friends',),
                //   Tab(text: 'Account',)
                // ],),
                // actions: [
                //   IconButton(
                //       onPressed: () {
                //         _controller.logOut();
                //       },
                //       icon: const Icon(Icons.logout))
                // ],

                ),
            // body: TabBarView(children: [
            //   GroupScreen(),
            //   FriendScreen(),
            //   AccountScreen(),
            // ],),
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
                    icon: const Icon(Icons.group),
                    onTap: () { _controller.updateIndex(0);},
                  ),
                  bottomSheetItem(
                    icon: const Icon(Icons.person),
                    onTap: () { _controller.updateIndex(1);},
                  ),
                  bottomSheetItem(
                    icon: const Icon(Icons.person),
                    onTap: () {
                      _controller.updateIndex(2);
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
  Icon? icon,
  Function()? onTap,
  int? index,
  int? currentIndex,
  Widget? child,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Stack(
      children: [
        Container(height: 50, width: 50, child: icon),
        if (child != null) child
      ],
    ),
  );
}
