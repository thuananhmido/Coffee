import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<CheckOut> {
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
        title: Text(" Xác nhận đặt hàng"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Thông tin nhận hàng"),
            ],
          )
        ],
      ),
    );
  }
}
