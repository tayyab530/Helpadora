import 'package:flutter/material.dart';

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
        context: context,
        builder: (ctx) {
          return Dialog(
            insetPadding: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.13,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Column(
                    children: [
                      Text(confirmationMessage),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(routeName);
                          },
                          child: Text('OK'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
