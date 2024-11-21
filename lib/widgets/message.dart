import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.textMessage, required this.isFromUser});

  final String textMessage;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            constraints: BoxConstraints(maxWidth: deviceWidth * 0.9),
            decoration: BoxDecoration(
                color: isFromUser
                    ? const Color(0x781AFF28)
                    : const Color(0x780199F8),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                MarkdownBody(data: textMessage),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
