import 'package:flutter/material.dart';
import 'package:login_app/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friends',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(body: const SplashScreen(),),
      debugShowCheckedModeBanner: false,
    );
  }
}


