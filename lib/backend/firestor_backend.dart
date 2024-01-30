import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

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

Future<void> setUserType(String type,String uid,TextEditingController _Email,TextEditingController _password) async {
  print("set user"+_Email.text);
  await FirebaseFirestore.instance.collection("users").doc(uid).set({
    'email':_Email.text,
    'userType':type,
    'uid':uid,
    'password':_password
  });
}

Future<bool> setBusDetail(TextEditingController _from,TextEditingController _to,TextEditingController _start_time,TextEditingController _end_time,TextEditingController _price,TextEditingController _sits,TextEditingController _bus_name,String _bus_type) async{
  Completer<bool> completer = Completer<bool>();
  bool result = false;
  try{
    print(_from.text+"AND"+_to.text+"AND"+_start_time.text+"AND");
    final data=<String, dynamic>{
      "from":_from.text,
      "to":_to.text,
      "start_time":_start_time.text,
      "end_time":_end_time.text,
      "price":_price.text,
      "sit":_sits.text,
      "bus_type":_bus_type,
      "bus_name":_bus_name.text
    };
    await FirebaseFirestore.instance.collection("bus_Time_Table").add(data).then((documentSnapshot){
      print("Added Data with ID: ${documentSnapshot.id}");

    });
    result=true;
  }catch(e){
    print("Faild add $e");
    result=false;
  }
  completer.complete(result);
  return completer.future;
}