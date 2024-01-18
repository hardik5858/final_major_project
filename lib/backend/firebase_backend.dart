import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../my_routes.dart';



void firebase_login (BuildContext context,TextEditingController _LoginEmail,TextEditingController _LoginPassword) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _LoginEmail.text,
          password: _LoginPassword.text
      );
      Navigator.pushNamed(context, MyRoutes.homepage);
      _LoginEmail.clear();
      _LoginPassword.clear();
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
    }
  }


void firebase_create_user(BuildContext context,TextEditingController _ReEmail,TextEditingController _RePassword) async{
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _ReEmail.text,
      password: _RePassword.text,
    );
    Navigator.pushNamed(context, MyRoutes.homepage);

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Fill propar detail")));
    }
  } catch (e) {
    print(e);
  }
}


void signOut() async{
    await FirebaseAuth.instance.signOut();
}

