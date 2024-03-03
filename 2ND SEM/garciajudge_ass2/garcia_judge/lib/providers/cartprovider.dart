import 'package:flutter/material.dart';
import 'package:garcia_judge/models/cartitem.dart';

class CartItems extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalNoItems => _items.length;

  void add(CartItem cartItem) {
    // int index = 0;
    // bool isFound = false;
    // for (; index <= _items.length - 1; index++) {
    //   if (_items[index].productCode == cartItem.productCode) {
    //     isFound = true;
    //     break;
    //   }
    // }

    // if (isFound) {
    //   _items[index].quantity++;
    // } else {
    //   _items.add(cartItem);
    // }

    //List<CartItem> _items
    print('contents of _items');
    _items.forEach((item) => print('${item.productCode} ${item.quantity}'));

    var codeList =
        _items.map((item) => item.productCode).toList(); //list of productcodes
    var index = codeList.indexOf(cartItem.productCode);
    print('$index index');
    if (index < 0) {
      _items.add(cartItem);
    } else {
      _items[index].quantity++;
    }

    notifyListeners();
  }
  void removeMultipleItems(List<int> indices) {
  indices.sort((a, b) => b.compareTo(a));
  
  for (int index in indices) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    } else {
      print('Invalid index: $index');
    }
  }
  
  notifyListeners();
}
  void decreaseQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      // Get the item at the specified index
      CartItem item = _items[index];
      // Decrease the quantity if it's greater than 1
      if (item.quantity > 1) {
        // Decrement the quantity by 1
        item.quantity--;
        notifyListeners();
      }
    } else {
      print('Invalid index: $index');
    }
  }

}
