import 'package:flutter/material.dart';
import 'package:resto_app/common/restaurant_detail_page_args.dart';
import 'package:resto_app/models/restaurant_model.dart';
import 'package:resto_app/pages/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: RestaurantDetailPageArguments(id: restaurant.id));
        },
      ),
    );
  }
}
