import 'package:flutter/material.dart';

class RestaurantSearchPage extends StatefulWidget {
  static final routeName = '/search-restaurnt';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 3.0),
                  ),
                  hintText: "Search people",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
