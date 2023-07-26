import 'package:fast_track/constants/constants.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;
  final bool isLoading;

  ChatMessage({required this.text, required this.isUserMessage,  required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final CrossAxisAlignment crossAxisAlignment =
        isUserMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    final Color backgroundColor =
        isUserMessage ? Constants().p_button : Constants().s_button;

    final TextStyle textStyle = TextStyle(
      color:
          isUserMessage ? Constants().p_button_text : Constants().s_button_text,
      fontWeight: FontWeight.normal,
    );

    final Widget messageContent = Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            text,
            style: textStyle,
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );

    final Widget avatar = CircleAvatar(
      child: Text(isUserMessage ? 'U' : 'B'),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isUserMessage) avatar,
            Expanded(child: messageContent),
            if (isUserMessage) avatar,
          ],
        ),
      ),
    );
  }
}
