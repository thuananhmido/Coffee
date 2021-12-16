import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
class CFProvider extends ChangeNotifier{
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
  /////////////add to cart ////////////
  List<Coffee> cartList = [];
  List<Coffee> newCartList = [];
  Coffee CartModle;
  void addToCart({
    @required String image,
    @required String name,
    @required int price,
    @required int quantity,
  }) {
    CartModle = Coffee(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
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
  void getDeleteIndex(int index){
    deleteIndex=index;
  }
  void delete(){
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
}

