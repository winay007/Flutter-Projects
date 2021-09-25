import 'dart:convert';

import 'package:http/http.dart' as http;

const API_KEY = " ";

class LocationHelper{
  static String generateLocationPreviewImage({double latitude,double longitude}){
     return  null;
  }

  static Future<String> getPlaceAddress(double lat,double lng) async {
    final url = null;
    final respone = await http.get(url);
    return json.decode(respone.body)['results'][0]['formatted_address'];
  }
}