import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/create_new_group_controller.dart';
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create a group'),
              actions: [
                GestureDetector(
                  onTap: () {
                    _controller.onSave();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Center(child: Text('Save'))),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                  : Icon(Icons.add_a_photo),
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
                        controller: _controller.nameGroupController,
                        decoration:
                            const InputDecoration(labelText: 'Group name'),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Type'),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return TypeOfGroup(
                              icon: _controller.listIconTypeOfGroup[index],
                              title: _controller.titleEachGroup[index]);
                        },
                        separatorBuilder: (ctx, index) {
                          return const SizedBox(
                            width: 15,
                          );
                        },
                        itemCount: _controller.listIconTypeOfGroup.length),
                  )
                ],
              ),
            ),
          );
        });
  }
}
