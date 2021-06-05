import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/rating_dialog.dart';
import 'package:intl/intl.dart';

class RatingItem extends StatelessWidget {
  final String lastMessage;
  final Timestamp time;
  final List<dynamic> chatMembers;
  final QueryDocumentSnapshot queryDetails;
  final String chatId;

  RatingItem(this.queryDetails, this.lastMessage, this.time, this.chatMembers,
      this.chatId);

  @override
  Widget build(BuildContext context) {
    var _time = DateFormat('hh:mm a').format(time.toDate());
    var _solverUid =
        checkSolver(chatMembers, queryDetails['poster_uid']).toString();
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.person,
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).dividerColor,
      ),
      title: Text(
        lastMessage,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(' $_time'),
      onTap: () {
        showRatingSlider(
          context,
          _solverUid,
          queryDetails.id,
        );
      },
    );
  }

  showRatingSlider(BuildContext context, String solverUid, String queryId) {
    return showDialog(
      context: context,
      builder: (context) {
        return RatingDialog(
          solverUid,
          queryId,
        );
      },
    );
  }

  checkSolver(List<dynamic> members, String posterUid) {
    return posterUid == members[0] ? members[1] : members[0];
  }
}
