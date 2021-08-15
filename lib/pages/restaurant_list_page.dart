import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/widgets/card_restaurant.dart';

class RestaurantListPage extends StatelessWidget {
  final ApiService apiService;
  const RestaurantListPage({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: apiService),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Restaurants App",
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "List of restaurant",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(
                            Icons.restaurant,
                            size: 50,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<RestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.state == ResultState.HasData) {
                        return ListView.builder(
                          itemCount: state.restaurant.count,
                          itemBuilder: (context, index) {
                            var restaurant =
                                state.restaurant.restaurants[index];
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
                  ),
                )
              ],
            ),
          ),
        )
      );
  }
}
