import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: state.restaurant.count,
            itemBuilder: (context, index) {
              var restaurant = state.restaurant.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return Center(
            child: Text(''),
          );
        }
      },
    );
  }
}
