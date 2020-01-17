import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class User {
  String userUid;
  String pseudo;
  String email;

  User({
    this.userUid,
    this.pseudo,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        userUid: json["userUid"],
        pseudo: json["pseudo"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "userUid": userUid,
        "pseudo": pseudo,
        "email": email,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
