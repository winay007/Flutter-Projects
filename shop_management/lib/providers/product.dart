import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {
      @required this.description,
      @required this.id,
       this.isFavorite = false,
      @required this.price,
      @required this.title,
      @required  this.imageUrl});
   
   void _setFavValue(bool newValue){
      isFavorite = newValue;
      notifyListeners();
   }

      void togglefavorite(String token,String userId) async {
        final oldStatus = isFavorite;
         isFavorite = !isFavorite;
        notifyListeners();
          final url =
        'https://flutter-app-af2a4-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
        try{
           final response = await  http.put(url , body: json.encode(
             isFavorite,              
        ) ,     
        ); 
          if(response.statusCode >= 400)
          {
           _setFavValue(oldStatus);
          }
        }
        catch(error){
            _setFavValue(oldStatus);
        }       
      }
}
