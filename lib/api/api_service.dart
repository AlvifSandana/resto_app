import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resto_app/models/restaurant_detail_model.dart';
import 'package:resto_app/models/restaurant_model.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _apiKey = '123456';

  Future<RestaurantModel> getAllRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailModel> getRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + 'detail/' + id));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail of restaurant');
    }
  }
}
