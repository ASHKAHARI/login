import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login(
      {this.id,
      this.email,
      this.name,
      this.profilePhoto,
     this.password,
     this.confirmPassword
     });

  int? id;
  String? email;
  String? name;
  String? profilePhoto;
  String? password;
  String? confirmPassword;
 

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        id: json["id"],
        email: json["email"],
        name: json["email"],
        profilePhoto: json["profilePhoto"],
        password: json["password"],
        confirmPassword: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "profilePhoto": profilePhoto,
       "password":password,
       "confirmPassword":confirmPassword,
      };
}
