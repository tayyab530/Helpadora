import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:provider/provider.dart';

import '../screens/main_screen.dart';
import '../widgets/rating_item.dart';
import '../services/db_firestore.dart';

class RatingScreen extends StatelessWidget {
  static const routeName = '/rating';

  @override
  Widget build(BuildContext context) {
    final Map<String, QueryModel> args =
        ModalRoute.of(context).settings.arguments;
    final QueryModel queryDetails = args['queryId'];
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          },
        ),
        title: Text('Select helper\'s chat'),
      ),
      body: FutureBuilder(
        future: _dbFirestore.getChatsForRating(queryDetails.qid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) return CircularProgressIndicator();
          return ListView(
            children: [
              if (snapshot.data.docs.isEmpty)
                Center(
                  child: Text('Oops! No solver yet.'),
                ),
              ...snapshot.data.docs.map(
                (chat) => RatingItem(
                  queryDetails,
                  chat.data()['last_message'],
                  chat.data()['time'],
                  chat.data()['chat_members'],
                  chat.id,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
