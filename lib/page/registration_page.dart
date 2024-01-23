import 'package:final_major_project/backend/firebase_backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../my_routes.dart';

class Registration_Page extends StatefulWidget {
  const Registration_Page({super.key});

  @override
  State<Registration_Page> createState() => _Registration_PageState();
}

class _Registration_PageState extends State<Registration_Page> {
  TextEditingController _ReEmail = TextEditingController();
  TextEditingController _RePassword = TextEditingController();
  TextEditingController _CoRePassword = TextEditingController();

  String Email="",RPassword="",CoPassword="";
  final _formKey=GlobalKey<FormState>();
  bool passTogle = false;
  bool CopassTogle=false;

  bool _error_value=false;
  MoveToHome() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      firebase_create_user(context, _ReEmail, _RePassword);
      _ReEmail.clear();
      _RePassword.clear();
      _CoRePassword.clear();
      setState(() {
        _error_value=false;
      });
    }else{
      setState(() {
        _error_value=true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme
      //     .of(context)
      //     .colorScheme
      //     .inversePrimary,
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Text("Registration",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 80,),
            Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Colors.black54
                      ),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _ReEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black
                                ),
                              ),
                              prefixIcon: Icon(Icons.email_outlined),
                              labelText: "Email",
                              hintText: "Enter your Email"
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is Empty";
                            }
                            bool ValidEmail = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (!ValidEmail) {
                              return "Enter Valid Email";
                            }
                            return null;
                          },
                          onChanged: (value){
                            Email=value.toString();
                          },
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formKey.currentState?.reset();
                                _error_value=false;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _RePassword,
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
                              onTap: () {
                                setState(() {
                                  passTogle = !passTogle;
                                });
                              },
                              child: Icon(passTogle ? Icons.visibility : Icons
                                  .visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is Empty";
                            } else if (value.length < 8) {
                              return "Password lengh should be atlest 8 charecter";
                            }
                          },
                          obscureText: !passTogle,
                          onChanged: (value){
                            RPassword=value.toString();
                          },
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formKey.currentState?.reset();
                                _error_value=false;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _CoRePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Colors.black
                                )
                            ),
                            prefixIcon: Icon(Icons.password_rounded),
                            labelText: "Confirm Password",
                            hintText: "Enter Your Password",
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  CopassTogle = !CopassTogle;
                                });
                              },
                              child: Icon(CopassTogle ? Icons.visibility : Icons
                                  .visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is Empty";
                            }
                            if(_RePassword.text != _CoRePassword.text){
                              return "Password is incurrcet";
                            }
                          },
                          obscureText: !CopassTogle,
                          onChanged: (value){
                            CoPassword=value.toString();
                          },
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formKey.currentState?.reset();
                                _error_value=false;
                              });
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            splashColor: Colors.amber,
                            onTap: () {
                              print("pass $RPassword");
                              MoveToHome();
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: 180,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("Registration..",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20),),

                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, MyRoutes.loginpage);
                                },
                                child: Text("< Login Screen",style: TextStyle(fontSize: 15,color: Colors.blue),))
                          ],
                        )

                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
