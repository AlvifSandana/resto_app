import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_provider.dart';
import 'package:resto_app/provider/restaurant_search_provider.dart';
import 'package:resto_app/widgets/search_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  static final routeName = '/search-restaurant';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController queryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) =>
              RestaurantSearchProvider(searchQuery: queryController.text),
          builder: (context, _) {
            return Column(
              children: [
                Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 50, bottom: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Search Restaurant",
                                  style: TextStyle(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "by name, category, and menus",
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 45,
                        child: TextField(
                          controller: queryController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "type here...",
                            suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<RestaurantSearchProvider>(context,
                                        listen: false)
                                    .searchRestaurant(queryController.text);
                              },
                              icon: Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<RestaurantSearchProvider>(
                  builder: (context, state, _) {
                    if (state.currentState == ResultState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.currentState == ResultState.HasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.searchResult.founded,
                          itemBuilder: (context, index) {
                            return SearchItem(
                                restaurant:
                                    state.searchResult.restaurants[index]);
                          },
                        ),
                      );
                    } else if (state.currentState == ResultState.NoData) {
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
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_off,
                              color: Colors.red,
                              size: 50,
                            ),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
