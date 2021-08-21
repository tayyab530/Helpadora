import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';
import 'src/constants/device_dimensions_info.dart';
import 'src/notifiers/queries.dart';
import 'src/notifiers/theme_data.dart';
import 'src/repositories/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => DeviceDimensionsInfo(),
      ),
      ChangeNotifierProvider(
        create: (context) => Repository(),
      ),
      ChangeNotifierProvider(
        create: (context) => QueriesNotifier(),
      ),
    ],
    child: App(),
  ));
}
