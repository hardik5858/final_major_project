import 'package:final_major_project/backend/firebase_backend.dart';
import 'package:final_major_project/page/admin/registration_admin.dart';
import 'package:final_major_project/page/login_page.dart';
import 'package:flutter/material.dart';

class Login_Admin extends StatefulWidget {
  const Login_Admin({super.key});

  @override
  State<Login_Admin> createState() => _Login_AdminState();
}

class _Login_AdminState extends State<Login_Admin> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController _LoginAdminEmail=TextEditingController();
  TextEditingController _LoginAdminPassword=TextEditingController();
  bool passTogle=false;

  bool _error_value=false;
  Admin_Authantication(){
    if(_formKey.currentState!.validate()){
      // admin_login(context, _LoginAdminEmail, _LoginAdminPassword);
      setState(() {
        _error_value=false;
      });
      _LoginAdminEmail.clear();
      _LoginAdminPassword.clear();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80,),
            Text("Admin...",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 100,),
            Form(
              key: _formKey,
                child:Container(
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      width: 1,
                      color: Colors.black
                    ),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType:TextInputType.emailAddress,
                          controller: _LoginAdminEmail,
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
                          controller: _LoginAdminPassword,
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
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formKey.currentState?.reset();
                                _error_value=false;
                              });
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
                              Admin_Authantication();
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
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>Registration_Admin()));
                                  },
                                  child: Text("Sign up",style: TextStyle(fontSize:15,color: Colors.blue),),)
                              ],)
                          ],
                        )
                      ],
                    ),
                  ),
                ) ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Page()));
                  },
                  child: Text("User Login Page",style: TextStyle(fontSize: 15,color: Colors.blue)))
            ],)
          ],
        ),
      ),
    );
  }
}
