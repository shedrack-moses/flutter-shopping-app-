import 'package:eccomerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends ChangeNotifier {
  final List<Product> _checkoutItems = [];

  List<Product> get checkoutItems => _checkoutItems;

  void addItemToCheckout(Product product) {
    _checkoutItems.add(product);
    notifyListeners();
  }

  void removeItemFromCheckout(Product product) {
    if (product.qty != -1 && product.qty != 0) {
      _checkoutItems.removeAt(_checkoutItems.indexOf(product));
    }

    notifyListeners();
  }
}
