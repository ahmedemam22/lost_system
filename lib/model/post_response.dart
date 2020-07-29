
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PostResponse postResponseFromJson(String str) => PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  String description;
  String imagepath;
  String location;
  String phone;
  String title;
  String time;
  String id;
  String find;

  PostResponse({
    this.description,
    this.imagepath,
    this.location,
    this.phone,
    this.title,
    this.time,
    this.id,
    this.find="not found"
});

  PostResponse.without(
  this.time,
      this.title,
      this.description,

    this.location,
    this.phone,
      this.imagepath,
      this.id
  );

  factory PostResponse.fromJson(DocumentSnapshot json) => PostResponse(
    description: json["description"],
    imagepath: json["imagepath"],
    location: json["location"],
    phone: json["phone"],
    title: json["title"],
    find: json["find"]
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "imagepath": imagepath,
    "location": location,
    "phone": phone,
    "title": title,
  };
}
