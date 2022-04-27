import 'package:flutter/material.dart';
import 'package:login_app/Back-End/loginmodal.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key, required this.data}) : super(key: key);
  String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(data)),
    );
  }

  // State<LoginScreen> createState() => _LoginScreenState();
}
