import 'package:flutter/cupertino.dart';

class DeviceDimensionsInfo with ChangeNotifier {
  late double kappBarHeight;
  late double ktabBarHeight;
  late double kstatusBar;
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
