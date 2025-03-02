// create_teaching_event_model.dart
import 'dart:convert';

class CreateEventModel {

}

// comment_model.dart
class CommentModel {
  final int commentId;
  final int postId;
  final String userId;
  final String comment;
  final DateTime createdAt;

  CommentModel({
    required this.commentId,
    required this.postId,
    required this.userId,
    required this.comment,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['comment_id'] as int,
      postId: json['post_id'] as int,
      userId: json['user_id'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
