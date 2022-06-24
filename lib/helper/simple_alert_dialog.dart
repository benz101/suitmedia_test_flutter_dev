import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleAlertDialog {
  static showSimpleAlertDialog(BuildContext context, String title,
      String content, VoidCallback onPressed) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  child: const Text('OK'), onPressed: onPressed)
            ],
          );
        });
  }
}
