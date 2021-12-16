import 'package:CoffeeAppUI/Screens/HomePage.dart';
import 'package:CoffeeAppUI/provider/cf_provider.dart';
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
  }) {
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Gía của sản phẩm này",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    " $price\VNĐ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        "$quantity",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: onTap,
            )
          ],
        )),
      ],
    );
  }

  Widget build(BuildContext context) {
    CFProvider provider = Provider.of<CFProvider>(context);
    int total = provider.totalprice();
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 65,
        decoration: BoxDecoration(
            color: Color(0xff3a3e3e), borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " $total\VNĐ",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              "Thanh toán",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      appBar: AppBar(
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
              provider.delete();
            },
            image: provider.cartList[index].image,
            name: provider.cartList[index].name,
            price: provider.cartList[index].price,
            quantity: provider.cartList[index].quantity,
          );
        },
      ),
    );
  }
}
