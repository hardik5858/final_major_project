import 'package:final_major_project/backend/firebase_backend.dart';
import 'package:final_major_project/my_routes.dart';
import 'package:final_major_project/page/admin/login_admin.dart';
import 'package:flutter/material.dart';

class Registration_Admin extends StatefulWidget {
  const Registration_Admin({super.key});

  @override
  State<Registration_Admin> createState() => _Registration_AdminState();
}

class _Registration_AdminState extends State<Registration_Admin> {
  TextEditingController _ReAdminEmail=TextEditingController();
  TextEditingController _ReAdminPassword=TextEditingController();
  TextEditingController _ReAdminCoPassword=TextEditingController();

  String Email="",RPassword="",CoPassword="";
  final _formKey=GlobalKey<FormState>();
  bool passTogle = false;
  bool CopassTogle=false;

  bool _error_value=false;
  Admin_Authantication(){
    if(_formKey.currentState!.validate()){
      print("its ok");
      print("heelo ${_ReAdminEmail} and $_ReAdminPassword");
      // admin_create(context, _ReAdminEmail, _ReAdminPassword);
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
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Text("Admin Registration",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 80,),
            Form(
                key: _formKey,
                child: Container(
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Colors.black54
                      ),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _ReAdminEmail,
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
                          controller: _ReAdminPassword,
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
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _ReAdminCoPassword,
                          decoration:  InputDecoration(
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
                            if(_ReAdminPassword.text != _ReAdminCoPassword.text){
                              return "Password is incurrcet";
                            }
                          },
                          obscureText: !CopassTogle,
                        ),
                        SizedBox(height: 30,),
                        Material(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            splashColor: Colors.amber,
                            onTap: (){
                              Admin_Authantication();
                            },
                            child: AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: 180,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("Registration...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Admin()));
                            }, child: Text("< Admin Login Screen",style: TextStyle(fontSize: 15,color: Colors.blue)))
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
