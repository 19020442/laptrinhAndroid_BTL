import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/group_controller.dart';
import 'package:no_name_app/routes/routes.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/group_item_widget.dart';
import 'package:no_name_app/widgets/new_group_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: GroupController(),
      builder: (GroupController _controller) {
        return Stack(
          children: [
            Center(
              child: _controller.isLoadingGroup
                  ? SpinKitThreeInOut(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          height: 20,
                          width: 20,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index.isEven ? Colors.blue : Colors.grey,
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 75,
                          // child: Row(
                          //   crossAxisAlignment: CrossAxisAlignment.end,
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     GestureDetector(
                          //       child: SvgPicture.asset(IconUtils.icSearch),
                          //     ),
                          //     const SizedBox(
                          //       width: 15,
                          //     ),
                          //   ],
                          // ),
                        ),
                        const Divider(),
                        // Container(
                        //   padding: const EdgeInsets.all(15),
                        //   height: 50,
                        //   width: double.infinity,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(),
                        //       GestureDetector(
                        //         onTap: () {
                        //           _controller.openFilterTable();
                        //         },
                        //         child: SvgPicture.asset(IconUtils.icFilterList),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_controller.totalOvrOnGroup == 0.0 &&
                                  _controller.listGroups.length > 0)
                                Container(
                                  child: Text(
                                    'Bạn đã hết nợ :)) ',
                                    style: FontUtils.mainTextStyle.copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              if (_controller.totalOvrOnGroup != 0.0)
                                Container(
                                  height: 50,
                                  child: Text(
                                    _controller.totalOvrOnGroup < 0
                                        ? 'Hêy ,Bạn còn nợ ${(_controller.totalOvrOnGroup * -1).toInt()} vnđ'
                                        : 'Ồ, Bạn đang cho mượn ${_controller.totalOvrOnGroup.toInt()} vnđ',
                                    style: FontUtils.mainTextStyle.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: _controller.totalOvrOnGroup < 0
                                            ? Colors.red[300]
                                            : Colors.green),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        if (_controller.listGroups.isEmpty)
                          Column(
                            children: [
                              // SizedBox(
                              //   height: 50,
                              // ),
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image:
                                          AssetImage(ImageUtils.noGroupImage),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Bạn chưa có nhóm',
                                style: FontUtils.mainTextStyle.copyWith(),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ],
                          ),
                        for (int i = 0; i < _controller.listGroups.length; i++)
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.MY_GROUP_SCREEN, arguments: {
                                'group-model':
                                    _controller.listGroups[i].keys.elementAt(0),
                                'user-model': _controller.userModel
                              });
                            },
                            child: GroupItemWidget(
                                itemData:
                                    _controller.listGroups[i].keys.elementAt(0),
                                ovr: _controller.listGroups[i].values
                                    .elementAt(0)),
                          ),
                        GestureDetector(
                            onTap: _controller.startCreateNewGroup,
                            child: AddButton(
                              color: _controller.listGroups.length == 0
                                  ? Colors.white
                                  : Colors.blue,
                              fontColor: _controller.listGroups.length == 0
                                  ? Colors.black
                                  : Colors.white,
                              icon: const Icon(
                                Icons.group_add,
                                color: Colors.black,
                              ),
                              title: 'Tạo nhóm mới',
                            ))
                      ],
                    ),
            ),
            if (_controller.isShowFilterTable)
              Positioned(
                  right: 15,
                  top: 125,
                  child: TableFilterList(
                    controller: _controller,
                  ))
          ],
        );
      },
    );
  }
}

class TableFilterList extends StatelessWidget {
  const TableFilterList({required this.controller, Key? key}) : super(key: key);
  final GroupController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: 200,
        width: 300,
        // color: Colors.grey,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    controller.onSelectFilter('all');
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        controller.filterTable['all'] == true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        child: Text(
                          'Tất cả nhóm',
                          style: FontUtils.mainTextStyle.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    controller.onSelectFilter('own');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        controller.filterTable['own'] == true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          'Nhóm bạn đang dư',
                          style: FontUtils.mainTextStyle.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
            Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    controller.onSelectFilter('owned');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        controller.filterTable['owned'] == true
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Text(
                          'Nhóm bạn đang vay',
                          style: FontUtils.mainTextStyle.copyWith(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
