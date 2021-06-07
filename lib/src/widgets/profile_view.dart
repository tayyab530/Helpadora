import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final String uid;

  ProfileView(this.uid);

  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);

    return FutureBuilder(
        future: _dbFirestore.getUserProfileData(uid),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          final _profile = snapshot.data.data();
          final List<dynamic> _listOfQueries = _profile['list_of_queries'];
          final List<dynamic> _points = _profile['ratings'];
          final double _totalPoints = sumOfPoints(_points);

          final TextStyle _primaryStyle = TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0);
          return Profile(
              profile: _profile,
              listOfQueries: _listOfQueries,
              primaryStyle: _primaryStyle,
              totalPoints: _totalPoints);
        });
  }

  double sumOfPoints(List<dynamic> points) {
    double _totalPoints = 0.0;
    points.forEach((element) {
      _totalPoints += element;
    });
    return _totalPoints;
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key key,
    @required Map<String, dynamic> profile,
    @required List listOfQueries,
    @required TextStyle primaryStyle,
    @required double totalPoints,
  })  : _profile = profile,
        _listOfQueries = listOfQueries,
        _primaryStyle = primaryStyle,
        _totalPoints = totalPoints,
        super(key: key);

  final Map<String, dynamic> _profile;
  final List _listOfQueries;
  final TextStyle _primaryStyle;
  final double _totalPoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.person,
              size: 40.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            ' ${_profile['user_name']} ',
            style: TextStyle(
              fontWeight:
                  Theme.of(context).primaryTextTheme.headline1.fontWeight,
              fontSize: 22.0,
              backgroundColor: Colors.black12,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '${_listOfQueries.length}',
                    style: _primaryStyle,
                  ),
                  Text('Queries'),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$_totalPoints',
                    style: _primaryStyle,
                  ),
                  Text('Points'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
