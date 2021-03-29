import 'package:flutter/material.dart';

class Photo {
  final String id;
  final String createdAt;

  final String title;
  final String imageUrl;

  Photo({
    @required this.id,
    @required this.createdAt,
    @required this.title,
    @required this.imageUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}

//To parse this JSON data, do

// import 'dart:convert';

// //final welcome = welcomeFromJson("https://60585b2ec3f49200173adcec.mockapi.io/api/v1/blogs");

// List<Album> welcomeFromJson(String str) =>
//     List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

// String welcomeToJson(List<Album> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Album {
//   Album({
//     this.id,
//     this.createdAt,
//     this.title,
//     this.imageUrl,
//   });

//   String id;
//   DateTime createdAt;
//   String title;
//   String imageUrl;

//   factory Album.fromJson(Map<String, dynamic> json) => Album(
//         id: json["id"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         title: json["title"],
//         imageUrl: json["imageUrl"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "createdAt": createdAt.toIso8601String(),
//         "title": title,
//         "imageUrl": imageUrl,
//       };
// }
