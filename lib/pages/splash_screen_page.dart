import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/common/styles.dart';
import 'package:resto_app/pages/restaurant_list_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.restaurant_outlined,
        size: 48.0,
        color: primaryColor,
      ),
    );
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    var apiService = new ApiService();
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return RestaurantListPage(apiService: apiService,);
        }),
      );
    });
  }
}
