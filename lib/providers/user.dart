import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String _name = "";
  String _contact = "";

  String get getName => _name;
  String get getContact => _contact;

  saveName(String name, String contact) {
    _name = name;
    _contact = contact;
    notifyListeners();
  }
}