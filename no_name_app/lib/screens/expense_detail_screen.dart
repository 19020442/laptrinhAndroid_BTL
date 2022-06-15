import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:no_name_app/controller/expense_controller.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/utils/image.dart';
import 'package:no_name_app/widgets/comment_bubble.dart';

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ExpenseController(),
      builder: (ExpenseController _controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[200],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    // height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 75,
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(15),
                            border: Border(
                              bottom: BorderSide(width: 4, color: Colors.grey),
                              left: BorderSide(width: 1, color: Colors.grey),
                              top: BorderSide(width: 1, color: Colors.grey),
                              right: BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(IconUtils.icExpense),
                              const Icon(Icons.expand_more_sharp)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _controller.expenseModel.name,
                              style: FontUtils.mainTextStyle
                                  .copyWith(fontSize: 25),
                            ),
                            Text(
                              '${_controller.expenseModel.value} vnđ',
                              style: FontUtils.mainTextStyle.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    // child: Text(_controller.),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < _controller.status.length; i++)
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              height: 30,
                              child: Text(
                                _controller.status[i],
                                style: FontUtils.mainTextStyle.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '  Bình luận',
                    style: FontUtils.mainTextStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          for (int i = 0;
                              i < _controller.listComment.length;
                              i++)
                            CommentBubble(
                                comment: _controller.listComment[i],
                                isYou: _controller.listComment[i].senderName ==
                                    _controller.userModel.name,
                                isJustNow: false)
                        ],
                      ),
                    ),
                  )),
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: Colors.grey[200],
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 6,
                            child: TextFormField(
                              controller: _controller.textCommentController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  isCollapsed: false,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  fillColor: Colors.white,
                                  hintStyle: FontUtils.mainTextStyle
                                      .copyWith(fontSize: 13),
                                  hintText: 'Thêm bình luận ...'),
                            )),
                        Flexible(
                            child: IconButton(
                          icon: Icon(Icons.send, color: Colors.green[200]),
                          onPressed: () {
                            _controller.onSendComment();
                          },
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
