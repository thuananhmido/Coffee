import 'package:CoffeeAppUI/Screens/Checkout.dart';
import 'package:CoffeeAppUI/Screens/HomePage.dart';
import 'package:CoffeeAppUI/constants.dart';
import 'package:CoffeeAppUI/model/coffee_model.dart';
import 'package:CoffeeAppUI/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget cartItem({
    @required String image,
    @required String name,
    @required int price,
    @required Function onTap,
    @required int quantity,
    @required int id,
    @required String switchvalue,
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
                "$name",
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
                      text: "x $quantity x $switchvalue ",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 130),
        IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: onTap,
        )
      ],
    );
  }

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
            color: kPrimaryLightColor, borderRadius: BorderRadius.circular(10)),
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
                    builder: (context) => CheckOut(),
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
                    "Tiếp Tục ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Giỏ Hàng"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (ctx, index) {
          provider.getDeleteIndex(index);
          return cartItem(
            onTap: () {
              String namedelete = provider.cartList[index].name;
              provider.delete(namedelete);
            },
            image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            quantity: provider.cartList[index].quantity,
            switchvalue: provider.cartList[index].switchvalue,
          );
        },
      ),
    );
  }
}
