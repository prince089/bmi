import 'package:jeetbmi/screen/daily.dart';
import 'package:jeetbmi/screen/homepage.dart';
import 'package:jeetbmi/screen/splashscreen.dart';
import 'package:jeetbmi/screen/userdetail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        '/userdetail': (context) => userpage(),
        '/homepage': (context) => userhome(),
        '/dailyprofile': (context) => CalendarPickerDemo(),
      },
    );
  }
}
