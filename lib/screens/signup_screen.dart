import 'package:flutter/material.dart';
import 'package:login_app/Back-End/loginmodal.dart';

import '../Back-End/login_service.dart';


class SignUp extends StatefulWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

 List users = [];
  // Color iconColor = Colors.lightBlue;

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  getAllData() async {
    var value = await LoginService().readAllFriends();

    users = <Login>[];

    users = value.map((value) => Login.fromJson(value)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  Center(child: Text("hello")),
    );
  }
}