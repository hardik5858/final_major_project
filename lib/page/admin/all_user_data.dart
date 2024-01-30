import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataScreen extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body:  StreamBuilder(
        // Replace this with your own stream
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Assuming you have a list of documents in the collection
          var documents = snapshot.data?.docs;

          return ListView.builder(
            itemCount: documents?.length,
            itemBuilder: (context, index) {
              var documentData = documents?[index].data();
              // Customize this based on your document structure
              return Card(
                child: ListTile(
                  title: Text(documentData?['email'] ?? "RAM"),
                  subtitle: Text(documentData?['userType'] ?? "Hanuman"),
                  trailing: IconButton(
                    onPressed: () {  },
                    icon: Icon(Icons.delete,color: Colors.black54,),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// class UserListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Users'),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: getAllUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('No users found.');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(snapshot.data![index].displayName ?? 'No Name'),
//                     subtitle: Text(snapshot.data![index].email),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Future<List<User>> getAllUsers() async {
//     List<User> users = [];
//
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .get();
//
//       querySnapshot.docs.forEach((doc) {
//         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//         User user = User.fromMap(data);
//         users.add(user);
//       });
//     } catch (e) {
//       print('Error getting users: $e');
//     }
//
//     return users;
//   }
// }
//
// class User {
//   final String displayName;
//   final String email;
//
//   User({required this.displayName, required this.email});
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       displayName: map['email'] ?? '',
//       email: map['userType'] ?? '',
//     );
//   }
// }
