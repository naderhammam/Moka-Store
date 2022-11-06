import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'config/helper/cache_helper.dart';
import 'config/helper/dio_helper.dart';
import 'core/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  ServicesLocator().init();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  runApp(MyApp());
}
