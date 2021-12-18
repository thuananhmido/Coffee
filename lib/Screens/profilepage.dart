import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage1 extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage1> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  currentUser() {
    final User user = _firebaseAuth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: currentUser())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return Column(
                children: <Widget>[
                  // Username
                  new Container(
                    child: new Text(
                      'Username',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.amber),
                    ),
                    margin:
                        new EdgeInsets.only(left: 10.0, bottom: 5.0, top: 10.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: document['userName'],
                          border: new UnderlineInputBorder(),
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: new TextStyle(color: Colors.grey)),
                    ),
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // Country
                  new Container(
                    child: new Text(
                      'Country',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.amber),
                    ),
                    margin:
                        new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: 'Viet Nam',
                          border: new UnderlineInputBorder(),
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: new TextStyle(color: Colors.grey)),
                    ),
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // Address
                  new Container(
                    child: new Text(
                      'Address',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.amber),
                    ),
                    margin:
                        new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: document['address'],
                          border: new UnderlineInputBorder(),
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: new TextStyle(color: Colors.grey)),
                    ),
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // About me
                  new Container(
                    child: new Text(
                      'Password',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.amber),
                    ),
                    margin:
                        new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: document['password'],
                          border: new UnderlineInputBorder(),
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: new TextStyle(color: Colors.grey)),
                    ),
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                  ),

                  // About me
                  new Container(
                    child: new Text(
                      'Email',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.amber),
                    ),
                    margin:
                        new EdgeInsets.only(left: 10.0, top: 30.0, bottom: 5.0),
                  ),
                  new Container(
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          hintText: document['email'],
                          border: new UnderlineInputBorder(),
                          contentPadding: new EdgeInsets.all(5.0),
                          hintStyle: new TextStyle(color: Colors.grey)),
                      keyboardType: TextInputType.number,
                    ),
                    margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
