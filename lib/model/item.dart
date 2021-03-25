import 'package:flutter/material.dart';

class FireBaseItem {
  String title;
  String itemId;
  double price;
  bool containHeal;
  double size;
  int quantity;
  String cookingLevel;

  FireBaseItem({
    this.title,
    this.quantity,
    this.itemId,
    this.price,
    this.containHeal,
    this.size,
    this.cookingLevel,
  });
}

class UserItem {
  InkWell image;
  String title;
  String itemId;
  double price;
  bool containHeal;
  double size;
  Radio blond;
  int quantity;
  Radio medium;
  Radio dark;
  Radio quarter;
  Radio half;
  Radio one;
  CheckboxListTile dep;

  UserItem({
    this.price,
    this.dep,
    this.image,
    this.half,
    this.quarter,
    this.quantity = 1,
    this.one,
    this.title,
    this.containHeal,
    this.blond,
    this.medium,
    this.dark,
    this.itemId,
    this.size,
  });
}
