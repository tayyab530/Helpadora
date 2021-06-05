import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/chats_rating_screen.dart';

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

  static Future<bool> alertDialogForQuery(
      BuildContext context,
      String confirmationMessage,
      List<String> buttonLabels,
      Color buttonBGcolor) async {
    return await showDialog<bool>(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(confirmationMessage),
          actions: [
            TextButton(
              onPressed: () async {
                return Navigator.of(context).pop(true);
              },
              child: Text(buttonLabels[0]),
              style: TextButton.styleFrom(
                backgroundColor: buttonBGcolor,
              ),
            ),
            TextButton(
              onPressed: () async {
                return Navigator.of(context).pop(false);
              },
              child: Text(buttonLabels[1]),
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
      BuildContext context,
      QueryDocumentSnapshot query,
      String confirmationMessage,
      List<String> buttonLabels,
      Color buttonBGcolor) async {
    return await showDialog<bool>(
      barrierDismissible: true,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(confirmationMessage),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed(
                    RatingScreen.routeName,
                    arguments: {'queryId': query});
                // return Navigator.of(context).pop(true);
              },
              child: Text(buttonLabels[0]),
              style: TextButton.styleFrom(
                backgroundColor: buttonBGcolor,
              ),
            ),
            TextButton(
              onPressed: () async {
                return Navigator.of(context).pop(false);
              },
              child: Text(buttonLabels[1]),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  static queryDetailsDialog(BuildContext context, QueryDocumentSnapshot query,
      bool showChaticon, List<String> chatmembers) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            title: Text('Details'),
            children: [
              Text(query['description'], textAlign: TextAlign.center),
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
