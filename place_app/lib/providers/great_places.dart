import 'dart:io';

import '../helpers/db_helper.dart';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/loaction_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id){
    return _items.firstWhere((place) => place.id == id );
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLoaction pickedlocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedlocation.latitude, pickedlocation.longitude);
    final updatedlocation = PlaceLoaction(
        latitude: pickedlocation.latitude,
        longitude: pickedlocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedlocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBhelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat':newPlace.location.latitude,
      'loc_lng':newPlace.location.longitude,
      'address':newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final datalist = await DBhelper.getData('user_places');
    _items = datalist.map((item) {
      return Place(
          id: item['id'],
          title: item['title'],
          image: File(item['image']),
          location: PlaceLoaction(latitude: item['loc_lat'],longitude: item['loc-lng'],address: item['address']),
          );
    }).toList();
    notifyListeners();
  }
}
