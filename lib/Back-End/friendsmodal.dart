import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login(
      {this.id,
      this.email,
     this.password});

  int? id;
  String? email;
  String? password;
 

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
       "password":password,
      };
}
