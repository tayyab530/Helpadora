import 'package:flutter/material.dart';
import 'package:helpadora/src/models/dialog_messages.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/screens/rating_screen.dart';

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
        return WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text(confirmationMessage),
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(routeName);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> alertDialogForQueryDelete(BuildContext context) async {
    return await showDialog<bool>(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(DialogMessages.queryDeleteConfirm),
          actions: [
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                return Navigator.of(context).pop(true);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).errorColor,
              ),
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                return Navigator.of(context).pop(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> alertDialogForQuerySolve(
      BuildContext context, QueryModel query) async {
    return await showDialog<bool>(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(DialogMessages.querySolveConfirm),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed(
                    RatingScreen.routeName,
                    arguments: {'queryId': query});
                // return Navigator.of(context).pop(true);
              },
              child: Text(
                'Proceed',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            TextButton(
              onPressed: () async {
                return Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  static queryDetailsDialog(BuildContext context, QueryModel query,
      bool showChaticon, Map<String, String> chatmembers) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text('Details'),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 23.0,
              vertical: 10.0,
            ),
            children: [
              Text(
                query.description,
                textAlign: TextAlign.left,
                softWrap: true,
              ),
              showChaticon
                  ? Container(
                      margin: EdgeInsets.only(right: 15.0),
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat', arguments: {
                            'queryDetails': query,
                            'chatMembers': chatmembers
                          });
                        },
                      ),
                    )
                  : Container(),
            ],
          );
        });
  }
}
