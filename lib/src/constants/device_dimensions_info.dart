import 'package:flutter/cupertino.dart';

class DeviceDimensionsInfo with ChangeNotifier {
  EdgeInsets padding;
  double width;
  double height;

  update(MediaQueryData mediaQuery, double appBarHeigth) {
    _parseMediaQuery(mediaQuery, appBarHeigth);
  }

  _parseMediaQuery(MediaQueryData _mediaQuery, double appBarHeigth) {
    width = _mediaQuery.size.width;
    height = _mediaQuery.size.height - (_mediaQuery.padding.top + appBarHeigth);
    padding = _mediaQuery.padding;
  }
}
