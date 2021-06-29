import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'package:helpadora/src/widgets/search_filter_bar.dart';
import 'package:provider/provider.dart';

import 'package:helpadora/src/services/auth_services.dart';
import '../../screens/write_query_screen.dart';
import '../../services/db_firestore.dart';
import '../list_of_queries.dart';

class CommunityTab extends StatelessWidget {
  static const icon = HelpadoraIcons.community;
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);
    final Map<String, bool> _filters = Provider.of<Filters>(context).filters;

    return Scaffold(
      body: StreamBuilder(
        stream: _dbFirestore.publicQueryStream
            .where('poster_uid', isNotEqualTo: _auth.getCurrentUser().uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // print("Length ${snapshot.data.docs.toString()}");
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          else {
            final _queriesNotifier = Provider.of<QueriesNotifier>(context);
            final _seachedQueries = _queriesNotifier.listOfQueries;
            var _listOfQueries =
                _seachedQueries != null ? _seachedQueries : snapshot.data.docs;

            return Column(
              children: [
                SearchFilterBar(_filters, _listOfQueries),
                Expanded(
                  child: ListOfQueries(
                    sortList(_listOfQueries, _filters),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
        child: CustomPaint(
          size: Size(21, 21),
          painter: AddIcon(),
        ),
      ),
    );
  }

  List<QueryDocumentSnapshot> sortList(
      List<QueryDocumentSnapshot> listOfQueries, Map<String, bool> _filters) {
    var _list = listOfQueries;
    if (_filters['title'])
      listOfQueries
          .sort((a, b) => a.data()['title'].compareTo(b.data()['title']));
    if (_filters['due_date'])
      listOfQueries
          .sort((a, b) => a.data()['due_date'].compareTo(b.data()['due_date']));
    if (_filters['location'])
      listOfQueries
          .sort((a, b) => a.data()['location'].compareTo(b.data()['location']));

    return _list;
  }
}

class AddIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(19.6667, 12.1667);
    path_0.lineTo(20.1667, 12.1667);
    path_0.lineTo(20.1667, 11.6667);
    path_0.lineTo(20.1667, 9);
    path_0.lineTo(20.1667, 8.5);
    path_0.lineTo(19.6667, 8.5);
    path_0.lineTo(12.1667, 8.5);
    path_0.lineTo(12.1667, 1);
    path_0.lineTo(12.1667, 0.5);
    path_0.lineTo(11.6667, 0.5);
    path_0.lineTo(9, 0.5);
    path_0.lineTo(8.5, 0.5);
    path_0.lineTo(8.5, 1);
    path_0.lineTo(8.5, 8.5);
    path_0.lineTo(1, 8.5);
    path_0.lineTo(0.5, 8.5);
    path_0.lineTo(0.5, 9);
    path_0.lineTo(0.5, 11.6667);
    path_0.lineTo(0.5, 12.1667);
    path_0.lineTo(1, 12.1667);
    path_0.lineTo(8.5, 12.1667);
    path_0.lineTo(8.5, 19.6667);
    path_0.lineTo(8.5, 20.1667);
    path_0.lineTo(9, 20.1667);
    path_0.lineTo(11.6667, 20.1667);
    path_0.lineTo(12.1667, 20.1667);
    path_0.lineTo(12.1667, 19.6667);
    path_0.lineTo(12.1667, 12.1667);
    path_0.lineTo(19.6667, 12.1667);
    path_0.close();

    Paint paint0stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint0stroke.color = Color(0xff323232).withOpacity(1.0);
    canvas.drawPath(path_0, paint0stroke);

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5238143, size.height * 0.5230000),
        Offset(size.width * 0.5234048, size.height * 0.5234048),
        [Color(0xffC4C4C4).withOpacity(1), Color(0xff0288D1).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_0, paint0fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
