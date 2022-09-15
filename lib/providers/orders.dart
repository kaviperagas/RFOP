import 'package:flutter/material.dart';
import 'package:rfop/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> meals;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.meals,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  dynamic listOrder() {
    List orderList = [];
    for (var element in _orders) {
      for (var e in element.meals) {
        e.quantity == 0
            ? null
            : orderList.add(
                'Name: ${e.name}, Price: RM ${e.price}, Quantity: ${e.quantity}');
      }
    }
    return orderList;
  }

  void addOrder(List<CartItem> cartMeals, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        meals: cartMeals,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _orders = [];
    notifyListeners();
  }
}
