import 'package:flutter/material.dart';

class HeaderListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
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
    );
  }
}
