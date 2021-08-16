import 'package:flutter/material.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/models/restaurant_search_response_model.dart';
import 'package:resto_app/widgets/search_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  static final routeName = '/search-restaurant';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final ApiService apiService = ApiService();
  RestaurantSearchResponseModel searchResult = RestaurantSearchResponseModel(
      error: false, founded: 0, restaurants: <Restaurant>[]);
  late SnackBar snackBar;
  TextEditingController queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiService.searchRestaurant(query: '').then((value) {
      setState(() {
        searchResult = value;
      });
      snackBar = SnackBar(
        content: Text("Available: ${searchResult.founded} data"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }).catchError((error) {
      snackBar = SnackBar(
        content: Text(error.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  void dispose() {
    super.dispose();
    queryController.dispose();
  }

  void searchRestaurant(String query) {
    apiService.searchRestaurant(query: queryController.text).then((value) {
      if (value.founded == 0) {
        snackBar = SnackBar(content: Text("Search not found"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        setState(() {
          searchResult = value;
        });
        snackBar = SnackBar(content: Text("Found ${value.founded} data"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }).catchError((e) {
      snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                            searchRestaurant(queryController.text);
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
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.founded,
                itemBuilder: (context, index) {
                  return SearchItem(restaurant: searchResult.restaurants[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
