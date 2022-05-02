import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../Back-End/login_service.dart';
import '../Back-End/loginmodal.dart';
import '../main.dart';

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

  // @override
  // void initState() {
  //   _passwordVisible = false;
  //   _confirmPasswordVisible = false;
  // }

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
                    child: imageFile == "" || imageFile == null
                        ? CircleAvatar(
                            child: FloatingActionButton(
                              child: const Icon(Icons.camera_alt),
                              onPressed: () {
                                getFromGallery();
                              },
                            ),
                            radius: 80, // Image radius
                            backgroundImage:
                                const AssetImage('assets/images/default.jpg'))
                        : CircleAvatar(
                            child: FloatingActionButton(
                              child: const Icon(Icons.camera_alt),
                              onPressed: () {
                                getFromGallery();
                              },
                            ),
                            radius: 80, // Image radius
                            backgroundImage:
                                FileImage(File(imageFile.toString())))),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is Required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is Required';
                      }
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Check your email";
                      }
                      for (var element in email) {
                        if (element.email == emailController.text) {
                          return 'Email has already taken';
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
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: const OutlineInputBorder(),
                        // Here is key idea
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
                          return 'Password is Required ';
                        } else if (value.length < 6) {
                          return 'password too short';
                        }

                        return null;
                      },
                    )),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordController,
                      obscureText:
                          !_confirmPasswordVisible, //This will obscure text dynamically
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm your password',
                        border: const OutlineInputBorder(),
                        // Here is key idea
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is Required ';
                        }
                        if (value.length < 6) {
                          return 'password too short';
                        } else if (value != confirmPass) {
                          return 'Password must be same as above';
                        }

                        return null;
                      },
                    )),
                const SizedBox(height: 25),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          saveDataToDb();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('You Signed in Successfully')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginApp()),
                          );
                        }
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Already have a account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginApp()),
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
