import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  String? text;
  String? dateTime;
  bool? isYourMessage;

  ChatBubbleWidget({Key? key,
    this.text,
    this.dateTime,
    this.isYourMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (isYourMessage!)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: (isYourMessage!)
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                border: (isYourMessage!)
                    ? null
                    : Border.all(color: Theme.of(context).primaryColor),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                text!,
                style: TextStyle(
                    color: (isYourMessage!) ? Colors.white : Colors.black),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(dateTime.toString())
          ],
        ));
  }
}