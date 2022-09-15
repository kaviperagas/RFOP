import 'package:flutter/material.dart';

import 'package:rfop/models/table.dart';

class Tables with ChangeNotifier {
  final List<TableNumber> _tables = [
    TableNumber(
      id: 't1',
      number: 'A1',
      imageUrl: 'https://media.istockphoto.com/photos/empty-wood-table-with-dark-vertical-table-background-picture-id1011317092?b=1&k=20&m=1011317092&s=170667a&w=0&h=uiPk6K5lnJKab5aDqkJkCbEpYfR1yvHZokd9cdaiOOY=',
    ),
    TableNumber(
      id: 't2',
      number: 'A2',
      imageUrl: 'https://media.istockphoto.com/photos/empty-wood-table-with-dark-vertical-table-background-picture-id1011317092?b=1&k=20&m=1011317092&s=170667a&w=0&h=uiPk6K5lnJKab5aDqkJkCbEpYfR1yvHZokd9cdaiOOY=',
    ),
    TableNumber(
      id: 't3',
      number: 'A3',
      imageUrl: 'https://media.istockphoto.com/photos/empty-wood-table-with-dark-vertical-table-background-picture-id1011317092?b=1&k=20&m=1011317092&s=170667a&w=0&h=uiPk6K5lnJKab5aDqkJkCbEpYfR1yvHZokd9cdaiOOY=',
    ),
    TableNumber(
      id: 't4',
      number: 'A4',
      imageUrl: 'https://media.istockphoto.com/photos/empty-wood-table-with-dark-vertical-table-background-picture-id1011317092?b=1&k=20&m=1011317092&s=170667a&w=0&h=uiPk6K5lnJKab5aDqkJkCbEpYfR1yvHZokd9cdaiOOY=',
    )
  ];

  List<TableNumber> get tables {
    return [..._tables];
  }

  TableNumber findById(String id){
    return _tables.firstWhere((tab) => tab.id == id);
  }

  String _tablenum = "";

  String get getTablenum => _tablenum;

  saveTableNum(String tablenum) {
    _tablenum = tablenum;
    notifyListeners();
  }

  void addTable() {
    notifyListeners();
  }
}