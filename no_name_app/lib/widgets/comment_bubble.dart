import 'package:flutter/material.dart';
import 'package:no_name_app/models/comment_model.dart';
import 'package:no_name_app/utils/fonts.dart';

class CommentBubble extends StatelessWidget {
  const CommentBubble(
      {required this.comment,
      required this.isYou,
      required this.isJustNow,
      Key? key})
      : super(key: key);
  final bool isYou;
  final bool isJustNow;
  final CommentModel comment;

  String getTimeDiff(DateTime dateComment) {
    final date2 = DateTime.now();
    var type = 'ngày trước';
    var difference = date2.difference(dateComment).inDays;
    if (difference == 0) {
      difference = date2.difference(dateComment).inHours;
      type = 'tiếng trước';
      if (difference == 0) {
        difference = date2.difference(dateComment).inMinutes;
        type = 'phút trước';
        if (difference == 0) {
          difference = date2.difference(dateComment).inSeconds;
          type = 'giây trước';
        }
      }
    }

    return (difference.toString() + " " + type);
  }

  @override
  Widget build(BuildContext context) {
    getTimeDiff(comment.dateTime!);
    return Container(
      width: double.infinity,
      alignment: isYou ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isYou ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            (isYou ? 'Bạn' : comment.senderName!) +
                " - " +
                getTimeDiff(comment.dateTime!),
            // + "${comment.dateTime!.day}",
            style: FontUtils.mainTextStyle.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: isYou ? Colors.green[200] : Colors.grey[300],
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(5),
            child: Text(
              comment.content!,
              style: FontUtils.mainTextStyle.copyWith(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
