import 'dart:async';
import 'package:login_app/screens/loginscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginApp())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: friends('LOGIN', 40).map((v) {
              return Center(
                child: v,
              );
            }).toList()),
      ),
    ));
  }
}

List<Widget> friends(String str, double size) {
  List<Widget> temp = [];
  for (int i = 0; i < str.length; i++) {
    var subText = str.substring(i, i + 1);

    temp.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          subText,
          style: TextStyle(color: Colors.white, fontSize: size),
        ),
        (i < str.length - 1)
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  ' . ',
                  style: TextStyle(
                      fontSize: size / 1.9,
                      fontWeight: FontWeight.bold,
                      color: ((i % 2 == 0) ? Colors.blue : Colors.red)),
                  textAlign: TextAlign.center,
                ),
              )
            : const SizedBox(),
      ],
    ));
  }
  return temp;
}
