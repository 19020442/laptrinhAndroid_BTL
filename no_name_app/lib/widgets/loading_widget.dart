import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Color backgroundColor;
  const LoadingWidget({
    Key? key,
    this.width,
    this.height,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: SizedBox(
          height: width ?? 100,
          width: height ?? 100,
          child: CupertinoTheme(
            data: CupertinoTheme.of(context).copyWith(
              brightness: Brightness.dark,
            ),
            child: const CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
  }
}
