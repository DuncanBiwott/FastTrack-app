import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fast_track/constants/constants.dart';
import 'package:fast_track/views/message_screen.dart';
import 'package:flutter/material.dart';

import '../api_key.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];

  final TextEditingController _textController = TextEditingController();

  void _sendMessageToBot(String text) async {
  try {
    Dio dio = Dio();
    
    Map<String, String> headers = {
      'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY,
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "top": 3,
      "question": text,
      "includeUnstructuredSources": true,
      "confidenceScoreThreshold": 0.3,
      "answerSpanRequest": {
        "enable": true,
        "topAnswersWithSpan": 1,
        "confidenceScoreThreshold": 0.3,
      }
    };

    Response response = await dio.post(
      'https://auto-chat-bot.cognitiveservices.azure.com/language/:query-knowledgebases?projectName=fast-track-Bot&api-version=2021-10-01&deploymentName=production',
      options: Options(headers: headers),
      data: jsonEncode(requestBody),
    );

    String botResponse = response.data['answers'][0]['answer'] ?? 'No response from the bot.';

     await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _messages.removeAt(0); 
      _messages.insert(
        0,
        ChatMessage(
          text: botResponse, 
          isUserMessage: false, isLoading: false,

        ),
      );
    });
  } catch (error) {
    print('Error sending message to bot: $error');
   
  }
}

void _handleSubmitted(String text) {

  _textController.clear();

  ChatMessage userMessage = ChatMessage(
    text: text,
    isUserMessage: true,
    isLoading: false,
  );
  setState(() {
    _messages.insert(0, userMessage);
  });

  ChatMessage loadingMessage = ChatMessage(
    text: 'Sending...',
    isUserMessage: false,
    isLoading: true,
  );
  setState(() {
    _messages.insert(0, loadingMessage);
  });
  _sendMessageToBot(text);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
  return IconTheme(
    data: const IconThemeData(color: Colors.blue),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
              enabled: !_messages.any((message) => message.isLoading), 
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Constants().p_button,
            ),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    ),
  );
}
}

