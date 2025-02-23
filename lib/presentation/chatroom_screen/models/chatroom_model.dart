// create_teaching_event_model.dart
import 'dart:convert';

class ChatroomModel {

}

class ChatMessage {
  final int messageId;
  final int chatroomId;
  final String senderId;
  final String senderName; // New field for sender name
  final String message;
  final DateTime createdAt;

  ChatMessage({
    required this.messageId,
    required this.chatroomId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['message_id'],
      chatroomId: json['chatroom_id'],
      senderId: json['sender_id'],
      senderName: json['sender_name'], // Get sender name from response
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
