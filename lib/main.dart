import 'dart:io';

import 'package:fidelway/styles/text_constants.dart';
import 'package:fidelway/utils/local_storage_helper.dart';
import 'package:flutter/material.dart';

import 'views/mainpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await LocalStorageHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TConstants.title,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFFFDD148, {
          50: Color(0xFFFDD148),
          100: Color(0xFFFDD148),
          200: Color(0xFFFDD148),
          300: Color(0xFFFDD148),
          400: Color(0xFFFDD148),
          500: Color(0xFFFDD148),
          600: Color(0xFFFDD148),
          700: Color(0xFFFDD148),
          800: Color(0xFFFDD148),
          900: Color(0xFFFDD148),
        }),
        fontFamily: 'Popin',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
