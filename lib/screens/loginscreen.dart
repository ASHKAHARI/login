import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/signUp_screen.dart';
import '../Back-End/login_service.dart';
import 'Logged_details_screen.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

final darkNotifier = ValueNotifier<bool>(false);
bool isDark = darkNotifier.value;

class LoginApp extends StatelessWidget {
  LoginApp({Key? key}) : super(key: key);

  static const String title = 'Login App';

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: darkNotifier,
        builder: (BuildContext context, bool isDark, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(primaryColor: Colors.blue),
            darkTheme: ThemeData.dark(),
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(title),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)),
                            ),
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext bc) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                child: Wrap(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/tamil.jpg'),
                                          ),
                                          title: Text('தமிழ்'),
                                        ),
                                      ),
                                      onTap: () {
                                        context.locale = Locale('ta', 'IND');
                                        
                                      },
                                    ),
                                    GestureDetector(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/english.png'),
                                          ),
                                          title: Text('English'),
                                        ),
                                      ),
                                      onTap: () {
                                        context.locale = Locale('en', 'IND');
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.language))
                ],
                leading: TextButton(
                  onPressed: () {
                    isDark = !isDark;
                    darkNotifier.value = isDark;
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    child: Icon(
                        isDark ? Icons.wb_sunny_outlined : Icons.bubble_chart),
                  ),
                ),
              ),
              body: LoginScreen(),
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
  var submitTextStyle = GoogleFonts.nunito(
      fontSize: 28,
      letterSpacing: 5,
      color: Colors.white,
      fontWeight: FontWeight.w300);

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
                  child: Text(
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
                  decoration: InputDecoration(
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password'.tr().toString(),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  // height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: AnimatedButton(
                    height: 55,
                    width: 150,
                    text: 'Login',
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: submitTextStyle,
                    backgroundColor: Colors.blue,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                    onPress: () async {
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
                                content: Text(
                                    'Invalid Credentials'.tr().toString())),
                          );
                        }
                        clear();
                      }
                    },
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: Text(
                      'Sign Up'.tr().toString(),
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
            ],
          )),
    );
  }

  chooseLanguage() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.19,
            child: Wrap(
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/tamil.jpg'),
                      ),
                      title: Text('Tamil'),
                    ),
                  ),
                  onTap: () {
                    context.locale = Locale('ta', 'IND');
                  },
                ),
                GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/english.png'),
                      ),
                      title: Text('English'),
                    ),
                  ),
                  onTap: () {
                    context.locale = Locale('en', 'US');
                  },
                ),
              ],
            ),
          );
        });
  }
}
