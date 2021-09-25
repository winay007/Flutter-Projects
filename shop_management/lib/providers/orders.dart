import 'package:flutter/foundation.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;

  OrderItem(
      {@required this.amount,
      @required this.id,
      @required this.dateTime,
      @required this.products});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Order(this.authToken,this.userId, this._orders);

  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> FetchAndSetOrders() async {
   final url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if(extractedData == null){
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  title: item['title'],
                  quantity: item['quantity']))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  void addOrder(List<CartItem> cartproducts, double total) async {
    final timestamp = DateTime.now();
    final url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartproducts
              .map((c) => {
                    'id': c.id,
                    'title': c.title,
                    'quantity': c.quantity,
                    'price': c.price,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
          amount: total,
          id: json.decode(response.body)['name'],
          dateTime: timestamp,
          products: cartproducts),
    );
    notifyListeners();
  }
}
