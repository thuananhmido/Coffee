import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Coffee> cartList = [];
  Coffee cartModle;
  Future<void> getCartList() async {
    List<Coffee> newCartList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('data')
        .where('idUser', isEqualTo: currentUser())
        .get();
    querySnapshot.docs.forEach(
      (element) {
        cartModle = Coffee(
            name: element.data()['name'],
            image: element.data()['image'],
            price: element.data()['price'],
            quantity: element.data()['quantity'],
            switchvalue: element.data()['switchvalue'],
            pricesp: element.data()['pricesp'],
            id: element.data()['id']);
        newCartList.add(cartModle);
      },
    );

    cartList = newCartList;
    notifyListeners();
  }

  get throwCFList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total += element.pricesp;
    });
    return total;
  }

  int deleteIndex;
  void getDeleteIndex(int index) {
    deleteIndex = index;
  }

// Future<void> deleteStudent(DocumentSnapshot doc) async {
//    db.collection("students").document(doc.documentID).delete();
//    clearForm();
// }
  Future<void> delete(iddelete) async {
    cartList.removeAt(deleteIndex);
    notifyListeners();
    FirebaseFirestore.instance.collection('data').doc(iddelete).delete();
  }
}

//////////get user///////////////
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
currentUser() {
  final User user = _firebaseAuth.currentUser;
  final uid = user.uid.toString();
  return uid;
}
