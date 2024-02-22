import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Temp extends StatefulWidget {
  const Temp({super.key});

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          addOrUpdateUserData("UlZKzzMb2o21i3ZcSwWp", "hardik", 10);

        }, child: Text("addd data"),
      ),
    );
  }
}
// Function to add or update data in Firestore
Future<void> addOrUpdateUserData(String userId, String name, int age) async {
  CollectionReference users=FirebaseFirestore.instance.collection("bus_Time_Table");

  // Create a map with the data you want to add or update
  Map<String, dynamic> userData = {
    'name': name,
    'age': age,
    // Add other fields as needed
  };
  // Use the set method with the merge parameter set to true
  // This will add or update the document in the 'users' collection
  await users.doc(userId).set(userData, SetOptions(merge: true));
  var data={
    "ticket":[1,2,3,4]
  };
  await users.doc(userId).collection("bus_ticket").doc("2KJZAvxwH61Wq3kBTxXO").set(data,SetOptions(merge: true));
print("succsessful");
}