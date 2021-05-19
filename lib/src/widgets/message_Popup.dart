import 'package:flutter/material.dart';

export '../models/dialog_messages.dart';

class Dialogs {
  static showErrorDialog(BuildContext context, String errorMessage) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(errorMessage),
            ),
          );
        });
  }

  static showConfirmationDialog(
      BuildContext context, String confirmationMessage, String routeName) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text(confirmationMessage),
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(routeName);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
