import 'package:flutter/material.dart';

class FriendlyMessage extends StatelessWidget {
  final Widget icon;
  final double iconSize;
  final String message;
  final double messageSize;

  const FriendlyMessage(
      {super.key,
      required this.icon,
      this.iconSize = 32,
      required this.message,
      this.messageSize = 18});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(
          message,
          style: TextStyle(fontSize: messageSize),
        )
      ],
    );
  }
}
