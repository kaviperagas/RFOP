import 'dart:math';

import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final String price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount => _items.values
      .fold(0, (quantity, cartItem) => cartItem.quantity + quantity);

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      var price = double.parse(cartItem.price);
      total += price * cartItem.quantity;
    });
    return total;
  }

  int itemQuantity(String mealId) {
    return _items[mealId] != null ? _items[mealId]!.quantity : 0;
  }

  void addItem(String mealId, String price, String name, String imageUrl) {
    if (_items.containsKey(mealId)) {
      _items.update(
        mealId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        mealId,
        () => CartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 1,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void reduceItem(String mealId, String price, String name, String imageUrl) {
    if (_items.containsKey(mealId)) {
      _items.update(
        mealId,
            (existingCartItem) => CartItem(
          id: existingCartItem.id,
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: max(existingCartItem.quantity - 1, 0),
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        mealId,
            () => CartItem(
          id: DateTime.now().toString(),
          name: name,
          price: price,
          quantity: 0,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String mealId){
    _items.remove(mealId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}
