import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoggedDetailsScreen extends StatelessWidget {
  LoggedDetailsScreen({Key? key, required this.data}) : super(key: key);
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Hello " + data['name'])),
    );
  }
}
