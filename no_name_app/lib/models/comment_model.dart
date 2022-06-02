import 'dart:convert';

class CommentModel {
  String? id;
  String? senderName;
  String? content;
  DateTime? dateTime;
  CommentModel({
    this.id,
    this.senderName,
    this.content,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': senderName,
      'content': content,
      'date': dateTime,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
        id: map['id'],
        senderName: map['sender'],
        content: map['content'],
        dateTime: map['date']
        // ownGroups: map['groups']
        );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));
}
