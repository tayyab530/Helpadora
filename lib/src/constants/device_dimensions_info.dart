import 'package:flutter/cupertino.dart';

class DeviceDimensionsInfo with ChangeNotifier {
  double kappBarHeight;
  double ktabBarHeight;
  double kstatusBar;
  bool isNotInitialized = true;

  update(double kappBarHeigth, double _ktabBarHeight) {
    print(isNotInitialized);
    if (isNotInitialized) {
      kappBarHeight = kappBarHeigth;
      ktabBarHeight = _ktabBarHeight;
      isNotInitialized = false;
    }
  }
}
