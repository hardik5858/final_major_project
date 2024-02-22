import 'package:final_major_project/backend/firestor_backend.dart';
import 'package:final_major_project/backend/variable_data.dart';
import 'package:final_major_project/page/result_bus_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Search_bus extends StatefulWidget {
  const Search_bus({super.key});

  @override
  State<Search_bus> createState() => _Search_busState();
}

class _Search_busState extends State<Search_bus> {
  TextEditingController _from =TextEditingController();
  TextEditingController _to=TextEditingController();
  TextEditingController _date=TextEditingController();
  DateTime selectedDate = DateTime.now();

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
  MoveToResult(){
     if(_formkey.currentState!.validate()){
       final Search_Data search_data=Search_Data(_from, _to, _date,selectedDate);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Search_Result_Bus(search_data: search_data)));
       setState(() {
         _error_value=false;
       });
     }else{
       setState(() {
         _error_value=true;
       });
     }
  }

  //user date select
  String formatDateTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(Duration(days: 1));

    if (dateTime.isAtSameMomentAs(today)) {
      String formattedDate = DateFormat("yyyy-MM-dd ").format(dateTime);
      formattedDate=formattedDate+DateFormat("hh:mm a").format(now);
      // Parse the formatted date string into a DateTime variable
      selectedDate = DateFormat("yyyy-MM-dd hh:mm a").parse(formattedDate);
      Data_Variable.selectedDate=selectedDate;
      print('Parsed DateTime: $selectedDate');
      print(formattedDate);
      return 'Today ${DateFormat('dd-MM hh:mm a').format(selectedDate)}';
    } else if (dateTime.isAtSameMomentAs(tomorrow)) {
      String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
      selectedDate=DateFormat("yyyy-MM-dd hh:mm a").parse(formattedDate);
      print(formattedDate);
      return 'Tomorrow ${DateFormat('hh:mm a').format(dateTime)}';
    } else {
      String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(dateTime);
      selectedDate=DateFormat("yyyy-MM-dd hh:mm a").parse(formattedDate);
      return DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child:Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              width: 1,
              color: Colors.black
            ),
            color: Color.fromARGB(255, 216, 216, 216)
          ),
          child:Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color:Colors.black
                  ),
                  color: Color.fromARGB(255, 166, 166, 166)
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _from,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
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
                        controller: _to,
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

                          if (_from.text==_to.text){
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: _date,
                  decoration:InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black
                      )
                    ),
                    prefixIcon: Icon(Icons.calendar_today_rounded,color: Colors.blue,),
                    labelText:"Date",
                    hintText: "Select date"
                  ),
                  onTap: () async{
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    );

                    if (selectedDate != null) {
                      String formattedDateTime = formatDateTime(selectedDate);
                      _date.text= formatDateTime(selectedDate);
                      print('Selected Date: $formattedDateTime');
                    }
                  },
                ),
              ),
              SizedBox(height: 15,),
              Material(
                  color: Colors.white,
                  elevation:8,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: (){
                    MoveToResult();
                  },
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: Duration(seconds: 500),
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height*0.07,
                    alignment: Alignment.center,
                    child:Text("Search Buses",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  ),
                ),
              ),


            ],
          ) ,
        )
    );
  }
}

class Search_Data{
  TextEditingController from;
  TextEditingController to;
  TextEditingController date;
  DateTime selectedDate;
  Search_Data(this.from,this.to,this.date,this.selectedDate);
}