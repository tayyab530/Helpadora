import 'package:flutter/cupertino.dart';

class DeviceDimensionsInfo with ChangeNotifier {
  EdgeInsets padding;
  double width;
  double height;
  bool isNotInitialized = true;

  update(MediaQueryData mediaQuery, double appBarHeigth) {
    _parseMediaQuery(mediaQuery, appBarHeigth);
  }

  _parseMediaQuery(MediaQueryData mediaQuery, double appBarHeigth) {
    print(isNotInitialized);
    if (isNotInitialized) {
      final _mediaQuery = mediaQuery;
      width = _mediaQuery.size.width;
      height =
          _mediaQuery.size.height - (_mediaQuery.padding.top + appBarHeigth);
      padding = _mediaQuery.padding;
      isNotInitialized = false;
    }
  }
}
