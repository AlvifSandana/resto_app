import 'package:flutter/material.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';
import 'package:resto_app/pages/restaurant_detail_page.dart';
import 'package:resto_app/pages/splash_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: customTextTheme
      ),
      home: SplashScreenPage(),
      routes: {
        RestaurantDetailPage.routeName : (context) => RestaurantDetailPage(
          restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant
        ),
      },
    );
  }
}

