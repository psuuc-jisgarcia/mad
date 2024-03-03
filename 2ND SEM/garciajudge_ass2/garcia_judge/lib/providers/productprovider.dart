import 'package:flutter/material.dart';
import 'package:garcia_judge/helpers/dbhelper.dart';
import 'package:garcia_judge/models/product.dart';

class Products extends ChangeNotifier {
  List<Product> _items = [];

  Future<List<Product>> get items async {
    var list = await DbHelper.fetchProducts();
    return list.map((element) => Product.fromMap(element)).toList();
  }

  void add(Product p) {
    DbHelper.insertProduct(p);
    notifyListeners();
  }

void removeProduct(int index) async {
  if (index >= 0 && index < _items.length) {
    // Remove the product from the list
    _items.removeAt(index);
    // Delete the product from the database
    // Notify listeners about the change
    notifyListeners();
  } else {
    print('Invalid index: $index');
  }
}




  void edit(Product p, int index) {
    _items[index] = p;
    notifyListeners();
  }

  Product item(int index) {
    return _items[index];
  }
void toggleFavorite(int index) {
    if (index >= 0 && index < _items.length) {
        _items[index].isFavorite = !_items[index].isFavorite;
        notifyListeners();
        print('Product at index $index toggled favorite: ${_items[index].isFavorite}');
    } else {
        print('Invalid index: $index');
    }
}

}
