import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poke/screens/chat_screen.dart';

class ChatMessage {
  final String message;
  late MessageType type;
  final String groupId;
  final String userId;
  final Timestamp timestamp;

  ChatMessage(
      {required this.message,
      required this.timestamp,
      required this.groupId,
      required this.userId});

  factory ChatMessage.fromFirestore(Map<String, dynamic> data) {
    return ChatMessage(
        message: data['message'],
        groupId: data['groupId'],
        userId: data['userId'],
        timestamp: data['timestamp']);
  }
}
