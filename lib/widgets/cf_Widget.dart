import 'package:flutter/material.dart';
import '../constants.dart';

class CFWidget extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final String description;
  final Function onTap;
  CFWidget(
      {@required this.onTap,
      @required this.image,
      @required this.price,
      @required this.name,
      @required this.description});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFFFECDF),
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
                      color: Color(0xFFFF7643),
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
                      color: Color(0xFFFFA53E),
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
                  radius: 100,
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
