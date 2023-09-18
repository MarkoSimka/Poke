import 'package:flutter/material.dart';
import 'package:poke/models/chat_message.dart';
import 'package:poke/screens/chat_screen.dart';

class ChatBubble extends StatefulWidget {
  ChatMessage chatMessage;
  ChatBubble({super.key, required this.chatMessage});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Reciever
            ? Alignment.topLeft
            : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type == MessageType.Sender
                ? Colors.white
                : Colors.grey.shade400),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(widget.chatMessage.message),
        ),
      ),
    );
  }
}
