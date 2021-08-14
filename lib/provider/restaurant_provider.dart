import 'package:flutter/material.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/models/restaurant_model.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantModel _restaurantModel;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantModel get restaurant => _restaurantModel;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getAllRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data Unavailable';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantModel = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error => $e';
    }
  }
}
