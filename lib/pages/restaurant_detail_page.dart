import 'package:flutter/material.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: restaurant.pictureId, 
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}"
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Divider(),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
