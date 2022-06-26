import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/create_new_group_controller.dart';
import 'package:no_name_app/screens/authentication/login_screen.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/cached_image.dart';
import 'package:no_name_app/widgets/type_of_group_widget.dart';

class CreateNewGroupScreen extends StatelessWidget {
  const CreateNewGroupScreen({Key? key}) : super(key: key);
  // Widget pickImageGroup(String imageUrl) {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CreateNewGroupController(),
        builder: (CreateNewGroupController _controller) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            // height: 1400,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Tạo nhóm mới',
                        style: FontUtils.mainTextStyle.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffde838a)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: _controller.pickImage,
                            child: Container(
                              height: 60,
                              width: 60,
                              child: Center(
                                child: _controller.imageGroup != ""
                                    ? CachedImageWidget(
                                        height: 50,
                                        width: 50,
                                        url: _controller.imageGroup)
                                    : Icon(Icons.add_a_photo, color: Color(0xff66b6d9),),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                              style: FontUtils.mainTextStyle.copyWith(),
                              onTap: () {
                                _controller.expandScreen();
                              },
                          controller: _controller.nameGroupController,
                          decoration: InputDecoration(
                            
                              labelText: 'Group name',
                              labelStyle: FontUtils.mainTextStyle.copyWith()),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Kiểu',
                      style: FontUtils.mainTextStyle.copyWith(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {
                                _controller.onSelectTypeGroup(index);
                              },
                              child: TypeOfGroup(
                                icon: _controller.listIconTypeOfGroup[index],
                                title: _controller.titleEachGroupTemp[index],
                                isChoosen:
                                    _controller.typeOfGroupIndexChoosen == index,
                              ),
                            );
                          },
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              width: 15,
                            );
                          },
                          itemCount: _controller.listIconTypeOfGroup.length),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Container(
                          width: 150,
                          child: ButtonWidget(
                            fontColor: Colors.white,
                              title: 'Tạo',
                              onTap: () {
                                _controller.onSave();
                              },
                              color: const Color(0xffde838a)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
