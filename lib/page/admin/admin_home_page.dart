import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Admin_Home_Page extends StatefulWidget {
  const Admin_Home_Page({super.key});

  @override
  State<Admin_Home_Page> createState() => _Admin_Home_PageState();
}

class _Admin_Home_PageState extends State<Admin_Home_Page> {
  TextEditingController _add_form=TextEditingController();
  TextEditingController _add_to=TextEditingController();
  TextEditingController _add_start=TextEditingController();
  TextEditingController _add_end=TextEditingController();
  TextEditingController _add_type=TextEditingController();
  TextEditingController _add_price=TextEditingController();
  TextEditingController _add_sits=TextEditingController();

  final _formkey=GlobalKey<FormState>();

  List<String> cityName=['ahmedabad','amreli','anand','aravalli','banaskantha','bharuch','bhavnagar','botad','chhota udaipur','dahod','dang','devbhumi dwarka','gandhinagar','gir somnath','jamnagar','kheda','kutch','mahisagar','mehsana','morbi','narmada','navsari','panchmahal','patan','porbandar','rajkot','sabarkantha','surat','surendranagar','tapi','vadodara','valsad'];

  valid(String value){
    String retval="" ;
    for(int i=0;i<cityName.length;i++){
      String name=cityName[i].toString();
      if(value!=name){
        retval="Your City Name $value Is Invalid";
      }else{
        return null;
      }
    }
    return retval;
  }

  bool _error_value=false;
  Add_Data(){
    if(_formkey.currentState!.validate()){
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
      backgroundColor: Color.fromARGB(255, 255, 123, 123),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,right: 5,top: 50),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 185, 81),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 2
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white
                          ),
                          child: TextFormField(
                            controller: _add_form,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              borderSide:BorderSide(
                                width: 1,
                                color: Colors.black
                              )
                              ),
                              prefixIcon: Icon(Icons.location_searching,color: Colors.green,),
                              labelText: "From",
                              hintText: "Your Location",
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Empty";
                              }
                              var re=valid(value.toString());
                              if(re!=null){
                                return re;
                              }
                              return null;
                            },
                            onTap: (){
                              if(_error_value){
                                setState(() {
                                  _formkey.currentState?.reset();
                                  _error_value=false;
                                });
                              }
                            },
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white
                        ),
                        child: TextFormField(
                          controller: _add_to,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.yellow
                                  )
                              ),
                              prefixIcon: Icon(Icons.location_on,color: Colors.red,),
                              labelText: "To",
                              hintText: "Destination"
                          ),
                          validator: (value){
                            if(value!.isEmpty){
                              return "This Field is Empty";
                            }

                            if (_add_form.text==_add_to.text){
                              return "Same City Name Not Allow";
                            }

                            var re=valid(value.toString());
                            if(re!=null){
                              return re;
                            }
                            return null;
                          },
                          onTap: (){
                            if(_error_value){
                              setState(() {
                                _formkey.currentState?.reset();
                                _error_value=false;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          controller: _add_start,
                          decoration:InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.access_time_outlined,color: Colors.blue,),
                              labelText:"Start Time",
                              hintText: "Start time"
                          ),
                          onTap: ()async{
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime:TimeOfDay.now(),
                            );
                            if(picked != null){
                              setState(() {
                                _add_start.text= picked.format(context);
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.none,
                          controller: _add_end,
                          decoration:InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black
                                  )
                              ),
                              prefixIcon: Icon(Icons.av_timer,color: Colors.blue,),
                              labelText:"End Time",
                              hintText: "End time"
                          ),
                          onTap: ()async{
                            DateTime? datePicker=await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            if(datePicker != null){
                              setState(() {
                                _add_end.text= DateFormat("dd-MM-yyyy").format(DateTime.now()) ;
                              });
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
