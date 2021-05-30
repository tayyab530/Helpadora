import 'package:flutter/cupertino.dart';

class ChatRepo with ChangeNotifier {
  String solverUid;
  String posterUid;

  updateSolverUid(String sUid) {
    solverUid = sUid;
    notifyListeners();
  }

  updatePosterUid(String pUid) {
    posterUid = pUid;
    notifyListeners();
  }
}
