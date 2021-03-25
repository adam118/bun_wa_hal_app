import 'package:bun_wa_hal/model/item.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List<UserItem> _userItems = [];
  double _totalPrice = 0.0;

  void add(UserItem userItem) {
    if (_userItems.contains(userItem)) {
      userItem.quantity++;
      _totalPrice += userItem.price;

      notifyListeners();
    } else {
      _userItems.add(userItem);
      _totalPrice += userItem.price;
      notifyListeners();
    }
  }

  void remove(UserItem userItem) {
    if (userItem.quantity == 1) {
      _userItems.remove(userItem);
      _totalPrice -= userItem.price;
      notifyListeners();
    } else {
      userItem.quantity--;
      _totalPrice -= userItem.price;
      notifyListeners();
    }
  }

  int get count {
    return _userItems.length;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<UserItem> get basketItems {
    return _userItems;
  }
}
