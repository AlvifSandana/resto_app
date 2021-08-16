import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/pages/restaurant_search_page.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/widgets/card_restaurant.dart';
import 'package:resto_app/widgets/list_page_header.dart';

class RestaurantListPage extends StatelessWidget {
  final ApiService apiService;
  const RestaurantListPage({required this.apiService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProvider(apiService: apiService),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  HeaderListPage(),
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
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cloud_off,
                                  color: Colors.red,
                                  size: 50,
                                ),
                                Text(
                                  state.message,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
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
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RestaurantSearchPage.routeName);
          },
          child: Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
