import 'package:CoffeeAppUI/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  currentUser() {
    final User user = _firebaseAuth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name, _email, _password, _address, _docId;
  update() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      updatepass() {
        final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        User currentUser1 = firebaseAuth.currentUser;
        currentUser1.updatePassword("$_password").catchError((err) {
          // An error has occured.
        });
      }

      try {
        DocumentReference _fireStore =
            Firestore.instance.collection('users').document(currentUser());
        Map<String, dynamic> students = {
          "userName": _name,
          // "email": _email,
          "address": _address,
          "password": _password,
          "id": currentUser(),
        };
        _fireStore.update(students).whenComplete(() {
          print("$_name updated");
        });
        updatepass();
      } catch (e) {
        //todo
      }
    }
    print("$_name updated");
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
              return Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Username
                      new Container(
                        child: new Text(
                          'Tên Hiển Thị',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: kPrimaryColor),
                        ),
                        margin: new EdgeInsets.only(
                            left: 10.0, bottom: 5.0, top: 10.0),
                      ),
                      new Container(
                        child: new TextFormField(
                            validator: (input) {
                              if (input.isEmpty) return document['userName'];
                            },
                            decoration: new InputDecoration(
                                hintText: document['userName'],
                                border: new UnderlineInputBorder(),
                                contentPadding: new EdgeInsets.all(5.0),
                                hintStyle: new TextStyle(color: Colors.grey)),
                            onSaved: (input) => _name = input),
                        margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                      ),

                      // Country
                      new Container(
                        child: new Text(
                          'Quốc Gia',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: kPrimaryColor),
                        ),
                        margin: new EdgeInsets.only(
                            left: 10.0, top: 30.0, bottom: 5.0),
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
                          'Địa Chỉ',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: kPrimaryColor),
                        ),
                        margin: new EdgeInsets.only(
                            left: 10.0, top: 30.0, bottom: 5.0),
                      ),
                      new Container(
                        child: new TextFormField(
                            validator: (input) {
                              if (input.isEmpty) return document['address'];
                            },
                            decoration: new InputDecoration(
                              hintText: document['address'],
                              border: new UnderlineInputBorder(),
                              contentPadding: new EdgeInsets.all(5.0),
                              hintStyle: new TextStyle(color: Colors.grey),
                            ),
                            onSaved: (input) => _address = input),
                        margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                      ),

                      // About me
                      new Container(
                        child: new Text(
                          'Password',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: kPrimaryColor),
                        ),
                        margin: new EdgeInsets.only(
                            left: 10.0, top: 30.0, bottom: 5.0),
                      ),
                      new Container(
                        child: new TextFormField(
                            validator: (input) {
                              if (input.isEmpty) return document['password'];
                            },
                            decoration: new InputDecoration(
                                hintText: document['password'],
                                border: new UnderlineInputBorder(),
                                contentPadding: new EdgeInsets.all(5.0),
                                hintStyle: new TextStyle(color: Colors.grey)),
                            onSaved: (input) => _password = input),
                        margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                      ),

                      // About me
                      // new Container(
                      //   child: new Text(
                      //     'Email',
                      //     style: new TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18.0,
                      //         color: kPrimaryColor),
                      //   ),
                      //   margin: new EdgeInsets.only(
                      //       left: 10.0, top: 30.0, bottom: 5.0),
                      // ),
                      // new Container(
                      //   child: new TextFormField(
                      //     validator: (input) {
                      //       if (input.isEmpty) return document['email'];
                      //     },
                      //     decoration: new InputDecoration(
                      //         hintText: document['email'],
                      //         border: new UnderlineInputBorder(),
                      //         contentPadding: new EdgeInsets.all(5.0),
                      //         hintStyle: new TextStyle(color: Colors.grey)),
                      //     onSaved: (input) => _email = input,
                      //     keyboardType: TextInputType.number,
                      //   ),
                      //   margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                      // ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 130),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Color(0xFFFF7643),
                              onPressed: update,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Cập Nhật",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
