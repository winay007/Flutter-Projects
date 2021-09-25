import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.price,
      @required this.title,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleitem(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid].quantity > 1) {
      _items.update(
          productid,
          (exsisting) => CartItem(
              id: exsisting.id,
              price: exsisting.price,
              title: exsisting.title,
              quantity: exsisting.quantity - 1));
    }
    else{
      _items.remove(productid);
    }
    notifyListeners();
  }

  int get itemcount {
    return _items.length == null ? 0 : _items.length;
  }

  void addItem(String productID, double price, String title) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (exsisting) => CartItem(
            id: exsisting.id,
            price: exsisting.price,
            title: exsisting.title,
            quantity: exsisting.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
      notifyListeners();
    }
  }
}
