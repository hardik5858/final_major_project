import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../page/admin/bus_ticket_data.dart';
import '../try/add_top_destination.dart';

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
    'password':_password.text
  });

  print("hello");
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

Future<bool> setBusDetail2(Store_Bus_Data store_bus_data) async{
  Completer<bool> completer = Completer<bool>();
  bool result = false;
  try{
    final data=<String,dynamic>{
      "from":store_bus_data.from,
      "to":store_bus_data.to,
      "start_time":store_bus_data.start_time,
      "end_time":store_bus_data.end_time,
      "bus_name":store_bus_data.bus_name,
      "bus_type":store_bus_data.bus_type,
      "price":store_bus_data.price,
      "sit":store_bus_data.sits,
      "booked":null
    };

    await FirebaseFirestore.instance.collection("bus_Time_Table").add(data).then((documentSnapshot){
      print("Added Data with ID: ${documentSnapshot.id}");

    });
    result=true;
  }catch (e){
    print("Faild add $e");
    result=false;
  }

  completer.complete(result);
  return completer.future;
}

Future<bool> setBusDetail3(Store_Bus_Data_Top_Destination store_bus_data) async{
  Completer<bool> completer = Completer<bool>();
  bool result = false;
  List<String> facalityName=[];
  if (store_bus_data.charging_port) facalityName.add("Charging USB Port");
  if (store_bus_data.ac_bus) facalityName.add("Ac Compartment");
  if (store_bus_data.internate) facalityName.add("Wifi Internet");
  if (store_bus_data.cctv) facalityName.add("CCTV");
  if (store_bus_data.reading_light) facalityName.add("Reading Light");
  if (store_bus_data.water_bottle) facalityName.add("Water Bottle");

  try{
    final data=<String,dynamic>{
      "to":store_bus_data.to,
      "start_time":store_bus_data.start_time,
      "end_time":store_bus_data.end_time,
      "bus_name":store_bus_data.bus_name,
      "bus_type":store_bus_data.bus_type,
      "price":store_bus_data.price,
      "sit":store_bus_data.sits,
      "facility":{
        if (store_bus_data.charging_port) "Charging USB Port": true,
        if (store_bus_data.ac_bus) "Ac Compartment": true,
        if (store_bus_data.internate) "Wifi Internet": true,
        if (store_bus_data.cctv) "CCTV": true,
        if (store_bus_data.reading_light) "Reading Light": true,
        if (store_bus_data.water_bottle) "Water Bottle": true,
      },
      "facility_name":facalityName,
      "booked":null,
    };

    await FirebaseFirestore.instance.collection("Top Destination").add(data).then((documentSnapshot){
      print("Added Data with ID: ${documentSnapshot.id}");
    });
    return true;
  }catch(e){
    print("Faild add $e");
    result=false;
  }
  completer.complete(result);
  return completer.future;
}