
import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  String username;
  String email;
  String pass;
  String phone;
  String imageProfile;

  UserResponse({
    this.username,
    this.email,
    this.pass,
    this.phone,
    this.imageProfile,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    username: json["username"],
    email: json["email"],
    pass: json["pass"],
    phone: json["phone"],
    imageProfile: json["image_profile"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "pass": pass,
    "phone": phone,
    "image_profile": imageProfile,
  };
}
