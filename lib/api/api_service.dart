import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:resto_app/models/create_review_response_model.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';
import 'package:resto_app/models/restaurant_model.dart';
import 'package:resto_app/models/restaurant_search_response_model.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _apiKey = '12345';

  Future<RestaurantModel> getAllRestaurant() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + 'list'));
      if (response.statusCode == 200) {
        return RestaurantModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } on SocketException {
      throw SocketException(
          'Koneksi bermasalah! Mohon cek koneksi internet Anda.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RestaurantDetailModel> getRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + 'detail/' + id));
      if (response.statusCode == 200) {
        return RestaurantDetailModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load detail of restaurant');
      }
    } on SocketException {
      throw SocketException(
          'Koneksi bermasalah! Mohon cek koneksi intenet Anda.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<RestaurantSearchResponseModel> searchRestaurant(
      {String query = ''}) async {
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + 'search?q=' + query));
      if (response.statusCode == 200) {
        return RestaurantSearchResponseModel.fromJson(
            json.decode(response.body));
      } else {
        return RestaurantSearchResponseModel.fromJson(
            json.decode(response.body));
      }
    } on SocketException {
      throw SocketException(
          'Koneksi bermasalah! Mohon cek koneksi internet Anda.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<CreateReviewResponseModel> postReview(
      String id, String name, String review) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + 'review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Auth-Token': _apiKey
        },
        body: jsonEncode(
            <String, String>{'id': id, 'name': name, 'review': review}),
      );
      if (response.statusCode == 200) {
        return CreateReviewResponseModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add new review');
      }
    } on SocketException {
      throw SocketException(
          'Koneksi bermasalah! Mohon cek koneksi internet Anda.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
