import 'package:flutter/material.dart';
import 'package:resto_app/common/restaurant_detail_page_args.dart';
import 'package:resto_app/models/restaurant_search_response_model.dart';
import 'package:resto_app/pages/restaurant_detail_page.dart';

class SearchItem extends StatelessWidget {
  final Restaurant restaurant;

  const SearchItem({
    Key? key,
    required this.restaurant
  }) : super(key: key);

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
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  color: Colors.red,
                  size: 20,
                ),
                Text(
                  restaurant.city,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName,
              arguments: RestaurantDetailPageArguments(id: restaurant.id));
        },
      ),
    );
  }
}
