import 'package:flutter/material.dart';

import 'app_route.dart';
import 'core/services/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper.init();
  runApp(const MyAppRoot());
}

