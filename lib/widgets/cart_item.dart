import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final int quantity;
  CartItem(
      {@required this.image,
      @required this.price,
      @required this.name,
      @required this.quantity});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "$price\K",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Hero(
                tag: image,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(image),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
