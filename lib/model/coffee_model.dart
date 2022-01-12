import 'package:flutter/material.dart';

class Coffee {
  String name, image, description, id;
  int price;
  int quantity;
  String idUser;
  String switchvalue;
  int pricesp;

  Coffee(
      {this.switchvalue,
      this.description,
      this.image,
      this.name,
      this.price,
      this.quantity,
      this.idUser,
      this.pricesp,
      this.id});
}
