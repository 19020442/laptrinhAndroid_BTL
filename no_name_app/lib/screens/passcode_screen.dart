import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:no_name_app/controller/passcode_controller.dart';
import 'package:no_name_app/screens/login_screen.dart';
import 'package:no_name_app/utils/fonts.dart';
import 'package:no_name_app/widgets/number_keyboard.dart';

class PassCodeScreen extends StatelessWidget {
  const PassCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PassCodeController(),
      builder: (PassCodeController _controller) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  _controller.stateEnterPassCode ==
                          PassCodeSettingMode.Step1SetPass
                      ? 'Nhập khóa mới của bạn'
                      : _controller.stateEnterPassCode ==
                              PassCodeSettingMode.Step2SetPass
                          ? 'Xác nhận khóa của bạn'
                          : _controller.stateEnterPassCode ==
                                  PassCodeSettingMode.ChangePass
                              ? 'Nhập mã mới'
                              : _controller.stateEnterPassCode ==
                                      PassCodeSettingMode.DeletePass
                                  ? 'Nhập mã của bạn'
                                  : 'Nhập mã khóa',
                  style: FontUtils.mainTextStyle
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Container(
                          margin: const EdgeInsets.all(5),
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: (_controller.currentStatePasscode[i] ==
                                              '' &&
                                          _controller.stateEnterPassCode ==
                                              PassCodeSettingMode
                                                  .Step1SetPass) ||
                                      (_controller.stateConfirmPassCode[i] ==
                                              '' &&
                                          _controller.stateEnterPassCode ==
                                              PassCodeSettingMode
                                                  .Step2SetPass) ||
                                      (_controller.currentStatePasscode[i] ==
                                              '' &&
                                          _controller.stateEnterPassCode ==
                                              PassCodeSettingMode.EnterPass) ||
                                      (_controller.currentStatePasscode[i] ==
                                              '' &&
                                          _controller.stateEnterPassCode ==
                                              PassCodeSettingMode.ChangePass) ||
                                      (_controller.currentStatePasscode[i] ==
                                              '' &&
                                          _controller.stateEnterPassCode ==
                                              PassCodeSettingMode.DeletePass)
                                  ? Colors.white
                                  : Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue)),
                        )
                    ],
                  ),
                ),
                Expanded(
                    child: NumberKeyBoard(
                  controller: _controller,
                )),
                Container(
                
                  
                  child: ButtonWidget(fontColor: Colors.white,title: 'Quay lại', onTap: (){
                    Get.back();
                  }, color: Colors.blue),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
