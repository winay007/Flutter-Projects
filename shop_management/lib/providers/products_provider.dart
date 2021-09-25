import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import 'product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];
  
  final String authToken;
  final String userID;
 
  ProductProvider(this.authToken,this.userID ,this._items);
  List<Product> get favItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  List<Product> get items {
    //  if(_showfavoritesonly){
    //    return _items.where((pItem) => pItem.isFavorite).toList();
    //  }
    return [..._items];
  }

  Future<void> fetchAndsetProducts([bool filterbyUser = false]) async {
    final filteredUrl = filterbyUser ? '&orderBy="createrId"&equalTo="$userID"':'';
    var  url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/products.json?auth=$authToken$filteredUrl';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData == null){
       return;
     }
    url =
    'https://flutter-app-af2a4-default-rtdb.firebaseio.com/userFavourites/$userID.json?auth=$authToken';
     final favoriteResponse = await http.get(url);
     final favoriteData =json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodID, prodData) {
        loadedProducts.add(Product(
            id: prodID,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: favoriteData == null ? false : favoriteData[prodID] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addproduct(Product product) async {
    final url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'createrId' : userID,
                }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
    final url =
          'https://flutter-app-af2a4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken';
    final exsistingIndex = items.indexWhere((p) => p.id == id);
    var exsistingProduct = items[exsistingIndex];
    _items.removeWhere((p) => p.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(exsistingIndex, exsistingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product.');
    }
    exsistingProduct = null;
    
  }
}
