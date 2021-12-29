import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';

class CFProvider extends ChangeNotifier {
  List<Coffee> cfList = [];
  Coffee foodModle;
  Future<void> getCFList() async {
    List<Coffee> newCFList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('coffee').get();
    querySnapshot.docs.forEach(
      (element) {
        foodModle = Coffee(
          name: element.data()['name'],
          image: element.data()['image'],
          price: element.data()['price'],
          description: element.data()['description'],
        );
        newCFList.add(foodModle);
      },
    );

    cfList = newCFList;
    notifyListeners();
  }

  get throwCFList {
    return cfList;
  }

  //////////get user///////////////
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  currentUser() {
    final User user = _firebaseAuth.currentUser;
    final uid = user.uid.toString();
    return uid;
  }

  /////////////add to cart ////////////
  List<Coffee> cartList = [];
  List<Coffee> newCartList = [];
  Coffee CartModle;
  void addToCart({
    @required String image,
    @required String name,
    @required int price,
    @required int quantity,
    @required String switchvalue,
  }) {
    CartModle = Coffee(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
      switchvalue: switchvalue,
    );
    // CollectionReference _fireStore = Firestore.instance.collection('data');
    // _fireStore.add({
    //   'name': name,
    //   'price': price,
    //   'image': image,
    //   'quantity': quantity,
    //   'idUser': currentUser(),
    // }).then((document) {
    //   // prints the document id when data adding succeed.
    //   debugPrint(document.documentID);
    // });
    DocumentReference _fireStore =
        Firestore.instance.collection('data').document(name);
    Map<String, dynamic> students = {
      "name": name,
      "price": price,
      "image": image,
      "quantity": quantity,
      "idUser": currentUser(),
      "switchvalue": switchvalue,
    };
    _fireStore.setData(students).whenComplete(() {
      print("$name created");
    });
    newCartList.add(CartModle);
    cartList = newCartList;
  }

  get throwCartList {
    return cartList;
  }

  int totalprice() {
    int total = 0;
    cartList.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  int deleteIndex;
  void getDeleteIndex(int index) {
    deleteIndex = index;
  }

  void delete() {
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}
