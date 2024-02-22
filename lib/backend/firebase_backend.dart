import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_major_project/backend/firestor_backend.dart';
import 'package:final_major_project/page/admin/admin_home_page.dart';
import 'package:final_major_project/page/home_page.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_routes.dart';



Future<bool> firebase_login (BuildContext context,TextEditingController _LoginEmail,TextEditingController _LoginPassword) async {
  Completer<bool> comparable=Completer<bool>() ;
  bool result=false;
  try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: _LoginEmail.text,
        password: _LoginPassword.text,
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      result=true;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("No user found for that email."),
        ));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Wrong password provided for that user."))
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Fill propar detail")));
      }
      result=false;
    }
    comparable.complete(result);
    return comparable.future;
  }

void firebase_create_user(BuildContext context,TextEditingController _ReEmail,TextEditingController _RePassword) async{
  try {
    print(_ReEmail.text);
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _ReEmail.text,
      password: _RePassword.text,
    );
    print("Sucsessful");
    print(_ReEmail.text);
    String uid=FirebaseAuth.instance.currentUser?.uid ?? "";
    setUserType("user",uid,_ReEmail,_RePassword);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }catch (e) {
    print(e);
  }
}
//admin authentication
void admin_login(BuildContext context,TextEditingController _LoginEmail,TextEditingController _LoginPassword) async{
  try{
    final credential =await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _LoginEmail.text,
        password: _LoginPassword.text
    );
    String userType=await getUserType();
    if(userType=='admin'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Home_Page()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Only admin can login"),
      ));
    }

  }catch(e){
  }
}
//admin user create
void admin_create(BuildContext context,TextEditingController _ReEmail,TextEditingController _RePassword) async{
  try{
    final credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _ReEmail.text,
        password: _RePassword.text
    );
    String uid=FirebaseAuth.instance.currentUser?.uid ?? "";
    setUserType("admin", uid, _ReEmail,_RePassword);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin_Home_Page()));
  }catch(e){

  }
}

void signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
}

