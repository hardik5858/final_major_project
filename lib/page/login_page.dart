import 'package:final_major_project/backend/firebase_backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../my_routes.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController _LoginEmail=TextEditingController();
  TextEditingController _LoginPassword=TextEditingController();
  bool passTogle=false;


  MoveToHome()async{
    if(_formKey.currentState!.validate()){
      firebase_login(context, _LoginEmail, _LoginPassword);
    }
  }
  void onChange() {
    setState(() {
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
      // backgroundColor:CupertinoColors.activeOrange,
        body:SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              Text("Login...",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 100,),
              Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.only(left: 5,right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            width: 1,
                            color: Colors.black54
                        ),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller:_LoginEmail,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  ),
                                ),
                                prefixIcon:Icon(Icons.email_outlined),
                                labelText: "Email",
                                hintText: "Enter your Email"
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Empty";
                              }
                              bool ValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                              if(!ValidEmail){
                                return "Enter Valid Email";
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _LoginPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.password_outlined),
                              labelText: "Password",
                              hintText: "Enter Your Password",
                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    passTogle = !passTogle;
                                  });
                                },
                                child: Icon(passTogle ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Empty";
                              }else if(value.length <8){
                                return "Password lengh should be atlest 8 charecter";
                              }
                            },
                            obscureText: !passTogle,
                          ),
                          SizedBox(height: 40,),
                          Material(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              splashColor: Colors.amber,
                              onTap: (){
                                MoveToHome();
                              },
                              child:AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text("Login..",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),

                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont have account ?",style: TextStyle(fontSize: 15),),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pushNamed(context, MyRoutes.registrationpage);
                                    },
                                    child: Text("Sign up",style: TextStyle(fontSize:15,color: Colors.blue),),)
                                ],)
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        )
    );
  }
}
