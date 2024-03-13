import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'admin_torisum_add_data.dart';

class Admin_Tourisum_Fair_Festival extends StatefulWidget {
  const Admin_Tourisum_Fair_Festival({super.key});

  @override
  State<Admin_Tourisum_Fair_Festival> createState() => _Admin_Tourisum_Fair_FestivalState();
}

class _Admin_Tourisum_Fair_FestivalState extends State<Admin_Tourisum_Fair_Festival> {
  final _formkey=GlobalKey<FormState>();
  final _formkey2=GlobalKey<FormState>();

  TextEditingController _add_name=TextEditingController();
  TextEditingController _add_location=TextEditingController();
  TextEditingController _add_start_date=TextEditingController();
  TextEditingController _add_end_date=TextEditingController();
  TextEditingController _add_district=TextEditingController();
  TextEditingController _add_key_heading_about_place=TextEditingController();
  TextEditingController _add_about_place=TextEditingController();

  List<String> cityName=['ahmedabad','amreli','anand','aravalli','banaskantha','bharuch','bhavnagar','botad','chhota udaipur','dahod','dang','devbhumi dwarka','gandhinagar','gir somnath','jamnagar','kheda','kutch','mahisagar','mehsana','morbi','narmada','navsari','panchmahal','patan','porbandar','rajkot','sabarkantha','surat','surendranagar','tapi','vadodara','valsad'];

  List<Entry> entries=[];
  bool _isUploading = false;
  XFile? _image;
  DateTime? startDate;
  DateTime? endData;
  List<XFile>? _imageList=[];
  int? days;
  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image=image;
      });
    }
  }

  Future<void> _selectStartDate(BuildContext context) async{
    final DateTime? pickedStartDate=await showDatePicker(
        context: context,
        initialDate: startDate ?? DateTime.now(),
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    print(pickedStartDate);
    if(pickedStartDate != null && pickedStartDate != startDate){
      setState(() {
        startDate=pickedStartDate;
        _add_start_date.text=DateFormat("yyyy-MM-dd").format(pickedStartDate);
        if(endData != null){
          setState(() {
            if (startDate != null && endData != null) {
              days = endData!.difference(startDate!).inDays;
            } else {
              days = null;
            }
          });
        }
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async{
    DateTime? initialEndDate = endData ?? startDate;

    // Ensure initialEndDate is on or after firstDate
    if (initialEndDate != null && initialEndDate.isBefore(startDate ?? DateTime(2024))) {
      initialEndDate = startDate;
    }
    final DateTime? pickedEndDate=await showDatePicker(
        context: context,
        initialDate: initialEndDate ?? DateTime(2024),
        firstDate: startDate ?? DateTime(2024),
        lastDate: DateTime(2025));
    if(pickedEndDate != null && pickedEndDate != endData){
      setState(() {
        endData=pickedEndDate;
        _add_end_date.text=DateFormat("yyyy-MM-dd").format(pickedEndDate);
        setState(() {
          if (startDate != null && endData != null) {
            days = endData!.difference(startDate!).inDays;
          } else {
            days = null;
          }
        });
      });
    }
  }

  void _addEntry(){
    String heading=_add_key_heading_about_place.text;
    String content=_add_about_place.text;
    setState(() {
      entries.add(Entry(id: UniqueKey().toString(), heading: heading, content: content));
    });
    _add_key_heading_about_place.clear();
    _add_about_place.clear();
  }

  void _submitFrom(BuildContext context) async{
    try{
      if(entries.isNotEmpty && _image != null){
        setState(() {
          _isUploading=true;
        });

        var firestoreInstance = FirebaseFirestore.instance;
        var collectionReference = firestoreInstance.collection('Fair and Festival Data');

        List<Map<String,String>> entriesData=entries.map((entry) {
          return {
            'heading': entry.heading,
            'content': entry.content,
          };
        }).toList();

        String imageUral=await uploadImageToFirebase(File(_image!.path));
        List<String> imageUrls=await _uploadImagesToFirebase();

        await collectionReference.add({
          'name':_add_name.text,
          'location':_add_location.text,
          'start_date':startDate,
          'end_date':endData,
          'district':_add_district.text,
          'other_data':entriesData,
          'image_url':imageUral,
          'image_urls':imageUrls
        });
        setState(() {
          _isUploading=false;
        });
        _add_name.clear();
        _add_location.clear();
        _add_start_date.clear();
        startDate=null;
        _add_end_date.clear();
        endData=null;
        entries=[];
        imageUrls=[];
        imageUral="";
      }
    }catch(e){
      print(e);
      setState(() {
        _isUploading=false;
      });
    }
  }

  Future<void> _pickImages() async{
    try{
      final ImagePicker _picker = ImagePicker();
      List<XFile>? result=await _picker.pickMultiImage();
      if(result != null && result.isNotEmpty){
        setState(() {
          _imageList=result;
        });
      }
    }catch(e){
      print("Error picking image: $e");
    }
  }

  Future<List<String>> _uploadImagesToFirebase() async{
    try{
      List<String> imageUrls=[];
      if(_imageList != null && _imageList!.isNotEmpty){

        for(XFile imageFile in _imageList!){
          String imageName=DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageRefrence=FirebaseStorage.instance.ref().child("image/fair_fastival/${_add_name.text}/$imageName");
          await storageRefrence.putFile(File(imageFile.path));
          String downloadURL=await storageRefrence.getDownloadURL();
          imageUrls.add(downloadURL);
        }
      }
      return imageUrls;
    }catch(e){
      print("Error uploading images: $e");
      return [];
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async{
    String imageName=basename(imageFile.path);
    Reference storageRefrenc=FirebaseStorage.instance.ref().child("image/fair_fastival/${_add_name.text}/$imageName");
    UploadTask uploadTask =storageRefrenc.putFile(imageFile);
    await uploadTask.whenComplete(() => print("Image upload to firebase"));
    return await storageRefrenc.getDownloadURL();
  }

  // Future<>
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.yellow,Colors.orange,Colors.orangeAccent]
            )
        ),
        child: Scaffold(
          appBar: AppBar(title: Text("Add Fair and Festival"),),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Slect Cover Image",style: TextStyle(fontSize: 16),),
                    Stack(
                      children: [
                        Container(
                          height: 180,
                          // constraints: BoxConstraints(maxWidth: 400.0),
                          width: MediaQuery.of(context).size.longestSide,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 1
                              )
                          ),
                          child: _image == null ? Center(child: Text("No Select Image")) : Image.file(File(_image!.path)),
                        ),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: IconButton(
                              onPressed: (){
                                _pickImage(context);
                              },
                              icon: Icon(Icons.add_a_photo),
                            )
                        )
                      ],
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _add_name,
                      decoration: myBoxDecoration(labelText: "Fair or Festival Name",),
                      validator: (value){
                        if(value!.isEmpty){
                          return "This Field is Empty";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _add_location,
                      decoration: myBoxDecoration(labelText: "Select Location",prefixIcon: Icon(Icons.location_on)),
                      validator: (value){
                        if(value!.isEmpty){
                          return "This Field is Empty";
                        }
                      },
                    ),
                    TypeAheadField(
                      controller: _add_district,
                        builder: (context,controller,focusNode){
                        return TextFormField(
                          controller: _add_district,
                          focusNode: focusNode,
                          decoration: myBoxDecoration(labelText: "District"),
                        );
                        },
                        itemBuilder:(context,suggestion){
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSelected: (value){
                          _add_district.text=value.toString();
                        },
                        suggestionsCallback: (search){
                          return cityName.where((element) =>
                              element.toLowerCase().contains(search.toLowerCase())).toList();
                        }),
                    TextFormField(
                      controller: _add_start_date,
                      keyboardType: TextInputType.none,
                      decoration: myBoxDecoration(labelText: "Start Date",prefixIcon: Icon(Icons.start_outlined)),
                      onTap: (){
                        _selectStartDate(context);
                      },
                      onChanged: (value){
                      },
                    ),
                    TextFormField(
                      controller: _add_end_date,
                      keyboardType: TextInputType.none,
                      decoration: myBoxDecoration(
                          labelText: "End Date",
                          prefixIcon: Icon(Icons.date_range_outlined),
                          suffixText: days != null ? "$days days" : ""),
                      onTap: (){
                        _selectEndDate(context);
                      },
                    ),
                    // TextFormField(
                    //   controller: _add_end_date,
                    //   keyboardType: TextInputType.none,
                    //   decoration: myBoxDecoration(
                    //     labelText: "End Date",
                    //     prefixIcon: Icon(Icons.date_range_outlined),
                    //     suffixText:  days != null ? "$days days" : "",
                    //   ),
                    //   onTap: () {
                    //     _selectEndDate(context);
                    //     setState(() {
                    //       if (startDate != null && endData != null) {
                    //         days = endData!.difference(startDate!).inDays;
                    //       } else {
                    //         days = null;
                    //       }
                    //     });
                    //   },
                    //   onChanged: (value) {
                    //     setState(() {
                    //       if (startDate != null && endData != null) {
                    //         days = endData!.difference(startDate!).inDays;
                    //       } else {
                    //         days = null;
                    //       }
                    //     });
                    //   },
                    // ),
                    Form(
                      key: _formkey2,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _add_key_heading_about_place,
                              decoration: myBoxDecoration(labelText: "Heading About place information",hintText: "Enter heading"),
                              style: TextStyle(fontWeight: FontWeight.w700),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a heading';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: _add_about_place,
                              keyboardType: TextInputType.multiline,
                              decoration: myBoxDecoration(labelText: "About place information",hintText: "Enter Information"),
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return "This Field is Empty";
                                }
                                return null;
                              },
                              maxLines: null,
                              minLines: 3,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child:  FloatingActionButton(
                                onPressed: (){
                                  if(_formkey2.currentState!.validate()){
                                    _addEntry();
                                  }
                                },
                                child: Icon(Icons.add),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10,),
                            if(entries.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: entries.length,
                                      itemBuilder: (context, index) {
                                        // _show_data.text='Heading: ${entries[index].heading}\nContent: ${entries[index].content}';
                                        return RichText(
                                            text: TextSpan(
                                                style: DefaultTextStyle.of(context).style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: '${entries[index].heading}:',
                                                      style: TextStyle(fontWeight: FontWeight.bold)
                                                  ),
                                                  TextSpan(
                                                    text: '${entries[index].content}',
                                                  )
                                                ]
                                            )
                                        );
                                      },
                                    ),
                                  ],
                                ),

                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        _pickImages();
                      },
                      child: Container(
                        height: 50,
                        // width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text("Select Image",style: TextStyle(fontSize: 16),),
                      ),
                    ),
                    // if(_imageList!.isNotEmpty)
                      // Row(
                      //   children: [
                      //         for(XFile imageFile in _imageList!)
                      //           Container(
                      //             height: 150,
                      //             width: 50,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(10),
                      //               border: Border.all(
                      //                 width: 1
                      //               )
                      //             ),
                      //             child: Image.file(File(imageFile.path)),
                      //           )
                      //   ],
                      // ),
                    SizedBox(height: 20,),
                    if(_imageList!.isNotEmpty)
                      SizedBox(
                        // height: 200,
                        child: GridView.builder(
                          shrinkWrap: true,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // You can adjust the number of columns as needed
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: _imageList?.length,
                            itemBuilder: (context,index){
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(File(_imageList![index].path),width: 100,height: 100,fit: BoxFit.cover,),
                              );
                            }),
                      ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Color.fromARGB(255, 160, 225, 127),
                          elevation:5,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            splashColor: Colors.red,
                            onTap: (){
                              if(_formkey.currentState!.validate()) {
                                _submitFrom(context);
                              }
                            },
                            child:AnimatedContainer(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              duration: Duration(seconds: 2),
                              width: MediaQuery.of(context).size.width*0.4,
                              height: MediaQuery.of(context).size.height*0.07,
                              alignment: Alignment.center,
                              child: _isUploading ? CircularProgressIndicator() : Text("Add Data",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
  InputDecoration myBoxDecoration({String? labelText,String? hintText,String? error,Icon? suffixIcon,Icon? prefixIcon,String? suffixText}){
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              width: 2,
              color: Colors.black
          )
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.green,
              width: 2
          )
      ),
        contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      labelText: labelText ?? "", // Set default empty string if labelText is null
      hintText: hintText ?? "",
      errorText:"${error?.isEmpty ?? false ? error : ''}",
      suffixIcon: suffixIcon != null ? InkWell(child: suffixIcon,onTap: (){print("hello");},) : null,
      prefixIcon: prefixIcon != null ? prefixIcon : null,
      suffixText: suffixText != null ? suffixText : null
    );
  }
}
