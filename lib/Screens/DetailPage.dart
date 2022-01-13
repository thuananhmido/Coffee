import 'package:CoffeeAppUI/Screens/Cart.dart';
import 'package:CoffeeAppUI/constants.dart';
import 'package:CoffeeAppUI/provider/cf_provider.dart';
import 'package:CoffeeAppUI/Screens//HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final int price;
  final String name;
  final String description;
  final String idUser;
  DetailPage({
    @required this.image,
    @required this.name,
    @required this.idUser,
    @required this.price,
    @required this.description,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  bool switchvalue = true;
  getSW() {
    if (switchvalue == true) {
      return "L";
    } else {
      return "S";
    }
  }

//lay price cong vao
  getSize() {
    if (switchvalue == true) {
      var a = (widget.price + 5) * quantity;
      return a;
    } else {
      var b = (widget.price * quantity);
      return b;
    }
  }

//lay price in ra
  getSizeString() {
    if (switchvalue == true) {
      var a = (widget.price + 5) * quantity;
      return "$a\K";
    } else {
      var b = (widget.price * quantity);
      return "$b\K";
    }
  }

  @override
  Widget build(BuildContext context) {
    CFProvider provider = Provider.of<CFProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                child: Image.network(widget.image,
                    height: 120, width: 400, fit: BoxFit.cover)),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 40, color: Color(0xFFFF7643)),
                  ),
                  Text(
                    "Coffee Mido Cảm Ơn Qúy Khách",
                    style: TextStyle(color: Colors.orange),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.add,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        getSizeString(),
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "S",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                        ),
                      ),
                      CupertinoSwitch(
                        trackColor: Colors.black,
                        value: switchvalue,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            switchvalue = value;
                          });
                        },
                      ),
                      Text(
                        "L",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Review ",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(color: Colors.black),
                  ),
                  Container(
                    height: 55,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Color(0xFFFF7643),
                      onPressed: () {
                        provider.addToCart(
                          image: widget.image,
                          name: widget.name,
                          price: widget.price,
                          quantity: quantity,
                          switchvalue: getSW(),
                          pricesp: getSize(),
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => CartPage(),
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
                            "Thêm giỏ hàng",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
