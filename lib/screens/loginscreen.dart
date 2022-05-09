import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/signUp_screen.dart';
import '../Back-End/login_service.dart';
import 'Logged_details_screen.dart';

final darkNotifier = ValueNotifier<bool>(false);
bool isDark = darkNotifier.value;

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  static const String _title = 'Login App';
  

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: _title,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(primaryColor: Colors.blue),
            darkTheme: ThemeData.dark(),
            home: Scaffold(
              appBar: AppBar(
                title: const Text(_title),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      isDark = !isDark;
                      darkNotifier.value = isDark;
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(
                          isDark ? Icons.wb_sunny_outlined : Icons.bubble_chart),
                    ),
                  )
                ],
              ),
              body:  LoginScreen(),
            ),
          );
        });
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginState();

  
}

class LoginState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  clear() {
    emailController.text = "";
    passwordController.text = "";
  }

  @override
  void dispose() {
    darkNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child:  Text(
                    'Login'.tr().toString(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your  email'.tr().toString(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is Required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is Required ';
                    }

                    return null;
                  },
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password'.tr().toString(),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var value = await LoginService().checkValidUser(
                            emailController.text, passwordController.text);

                        if (value.length > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoggedDetailsScreen(data: value[0])));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                                content: Text('Invalid Credentials'.tr().toString())),
                          );
                        }
                        clear();
                      }
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                   Text('tamil'),
                  TextButton(
                    child: const Text(
                      'tamil',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      context.locale = Locale('ta', 'IND');
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                   Text('english'),
                  TextButton(
                    child: const Text(
                      'english',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      context.locale = Locale('en', 'US');
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
