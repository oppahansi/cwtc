import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/app.locator.dart';
import 'app/app.router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  //MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
