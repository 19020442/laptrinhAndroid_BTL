import 'package:flutter/material.dart';
import 'package:no_name_app/utils/fonts.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const  EdgeInsets.symmetric(horizontal: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 75,
        ),
        Text(
          'Hoạt động',
          style: FontUtils.mainTextStyle
              .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ]),
    );
  }
}
