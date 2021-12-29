import 'package:CoffeeAppUI/Screens/HomePage.dart';
import 'package:CoffeeAppUI/constants.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
import 'package:CoffeeAppUI/provider/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Widget cartItem({
    @required String image,
    @required String name,
    @required int price,
    @required int quantity,
    @required int id,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "\$$price",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                      text: " x$quantity",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    int total = provider.totalprice();
    provider.getCartList();
    List<Coffee> singleFoodList = [];
    singleFoodList = provider.throwCFList;
    return Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 65,
          decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " $total\VNĐ",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              RaisedButton(
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
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
                      "Đặt Ngay ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(" Xác nhận đặt hàng"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('id', isEqualTo: currentUser())
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          'THÔNG TIN KHÁCH HÀNG',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(" Tên Người Nhận ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              Expanded(child: Text(document['userName']))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(" Địa Chỉ  ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              Expanded(child: Text(document['address']))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(" Số Diện Thoại  ",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              Expanded(child: Text(document['email']))
                            ],
                          ),
                        ),
                        // Container(
                        //   child: ListView.builder(
                        //     itemCount: provider.cartList.length,
                        //     itemBuilder: (ctx, index) {
                        //       return cartItem(
                        //         image: provider.cartList[index].image,
                        //         name: provider.cartList[index].name,
                        //         price: provider.cartList[index].price,
                        //         quantity: provider.cartList[index].quantity,
                        //       );
                        //     },
                        //   ),
                        // )
                      ]));
                }).toList(),
              );
            }));
  }
}
