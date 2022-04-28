import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.data}) : super(key: key);
  dynamic data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Hello "+data['name'])),
    );
  }

  // State<LoginScreen> createState() => _LoginScreenState();
}
