import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var db = FirebaseFirestore.instance;

void add_Userdata() {
  final user = <String, dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };
  db.collection("users").add(user).then((value) =>
      print('DocumentSnapshot added with ID: ${value}'));
}

  //admin authantication get user type
Future<String> getUserType() async{
  String uid=FirebaseAuth.instance.currentUser?.uid ?? "";
  DocumentSnapshot<Map<String,dynamic>> userDoc=await db.collection("users").doc(uid).get();
  return userDoc['userType'] ?? 'user';
}

