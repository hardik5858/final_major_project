import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

void add_Userdata(){
  final user=<String,dynamic>{
    "first": "Ada",
    "last": "Lovelace",
    "born": 1815
  };
  db.collection("users").add(user).then((value) => print('DocumentSnapshot added with ID: ${value}'));
}