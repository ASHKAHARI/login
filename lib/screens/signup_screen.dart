import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:login_app/screens/loginscreen.dart';
import '../Back-End/login_service.dart';
import '../Back-End/loginmodal.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  LoginService loginService = LoginService();
  String? imageFile;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  // ignore: prefer_typing_uninitialized_variables
  var confirmPass;
  List email = [];

  @override
  void initState() {
    getAllEmail();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    super.initState();
  }

  getAllEmail() async {
    var value = await LoginService().readAllDetails();
    email = <Login>[];
    email = value.map((value) => Login.fromJson(value)).toList();
    setState(() {});
  }

  saveDataToDb() {
    Login friend = Login();
    friend.email = emailController.text;
    friend.name = nameController.text;
    friend.password = passwordController.text;
    friend.confirmPassword = confirmPasswordController.text;
    loginService.saveUser(friend);
    clear();
  }

  clear() {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Stack(
                    children: <Widget>[
                      imageFile == "" || imageFile == null
                          ? GestureDetector(
                              onTap: () {
                                getFromGallery();
                              },
                              child: const CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage('assets/images/default.jpg')),
                            )
                          : GestureDetector(
                              onTap: () {
                                getFromGallery();
                              },
                              child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      FileImage(File(imageFile.toString()))),
                            ),
                      Positioned(
                          bottom: 15.0,
                          right: 24.0,
                          child: Icon(
                            Icons.add_a_photo,
                            size: 35,
                            color: Color.fromARGB(167, 0, 0, 0),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name'.tr().toString(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is Required'.tr().toString();
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email'.tr().toString(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is Required'.tr().toString();
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Check your email".tr().toString();
                      }
                      for (var element in email) {
                        if (element.email == emailController.text) {
                          return 'Email has already taken'.tr().toString();
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password'.tr().toString(),
                        hintText: 'Enter your password'.tr().toString(),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        confirmPass = value;
                        if (value == null || value.isEmpty) {
                          return 'Password is Required'.tr().toString();
                        } else if (value.length < 6) {
                          return 'password too short'.tr().toString();
                        }

                        return null;
                      },
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password'.tr().toString(),
                        hintText: 'Confirm your password'.tr().toString(),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is Required'.tr().toString();
                        }
                        if (value.length < 6) {
                          return 'password too short'.tr().toString();
                        } else if (value != confirmPass) {
                          return 'Password must be same as above'
                              .tr()
                              .toString();
                        }

                        return null;
                      },
                    )),
                const SizedBox(height: 25),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text('Sign Up'.tr().toString()),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          saveDataToDb();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('You Signed up  Successfully'
                                    .tr()
                                    .toString())),
                          );
                          await Future.delayed(
                              const Duration(seconds: 4), () {});
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => LoginApp()),
                          );
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    Text('Already have an account?'.tr().toString()),
                    TextButton(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(builder: (context) => LoginApp()),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
      ),
    );
  }

  getFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = image.path;
      });
    }
  }
}
