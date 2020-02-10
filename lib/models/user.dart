import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class User {
  // uid is in StateModel FirebaseUser bject
  String pseudo;

  User({
    this.pseudo,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        pseudo: json["pseudo"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "pseudo": pseudo ?? null,
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
