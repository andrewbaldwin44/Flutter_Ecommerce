import 'dart:collection';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Map<String, dynamic>?> products = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Map<String, dynamic>?> get items =>
      UnmodifiableListView(products);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => products.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Map<String, dynamic>? item) {
    products.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    products.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
