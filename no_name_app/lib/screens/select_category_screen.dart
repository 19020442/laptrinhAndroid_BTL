import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/add_expense_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';

class SelectCategoryScreen extends StatelessWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(IconUtils.icExpenseList[0].values.elementAt(0));
    return GetBuilder(
      init: AddExpenseController(),
      builder: (AddExpenseController _controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              'Chọn danh mục',
              style: FontUtils.mainTextStyle.copyWith(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.separated(
                itemBuilder: (ctx, index) {
                  return TextButton(
                      onPressed: () {
                        _controller.onSelectCategory(index);
                      },
                      child: Container(
                        // padding: const EdgeInsets.all(10),
                        height: 50,
                        width: double.infinity,
                        // color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconUtils.icExpenseList[index].values
                                  .elementAt(0),
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              IconUtils.icExpenseList[index].keys.elementAt(0),
                              style: FontUtils.mainTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                            Spacer(),
                            if (_controller.cateIndexSelected == index)
                              Icon(
                                Icons.check,
                                size: 30,
                                color: Colors.grey[500],
                              )
                          ],
                        ),
                      ));
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
                itemCount: IconUtils.icExpenseList.length),
          ),
        );
      },
    );
  }
}
