import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/models/restaurant_search_response_model.dart';
import 'package:resto_app/provider/restaurant_provider.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  String searchQuery;

  late RestaurantSearchResponseModel _restaurantSearchResponseModel;
  late ResultState _state;
  String _message = '';

  RestaurantSearchProvider({
    required this.searchQuery,
  }) {
    searchRestaurant(searchQuery);
  }

  RestaurantSearchResponseModel get searchResult =>
      _restaurantSearchResponseModel;
  ResultState get currentState => _state;
  String get message => _message;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.searchRestaurant(query: query);
      if (response.error == false && response.founded > 0) {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantSearchResponseModel = response;
      } else if (response.error == false && response.founded == 0) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No result found';
      } else if (response.error == true) {
        _state = ResultState.Error;
        notifyListeners();
        return _message = 'Error Occured!';
      }
    } on SocketException {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'Koneksi bermasalah! Mohon cek koneksi internet Anda.';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
