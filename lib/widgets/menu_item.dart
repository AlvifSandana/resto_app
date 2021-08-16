import 'package:flutter/material.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.grey,
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    category.name,
                    style:
                        TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "IDR xxxxx",
                    style: TextStyle(
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
