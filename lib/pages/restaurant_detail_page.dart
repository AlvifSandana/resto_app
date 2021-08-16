import 'package:flutter/material.dart';
import 'package:resto_app/api/api_service.dart';
import 'package:resto_app/common/restaurant_detail_page_args.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';
import 'package:resto_app/widgets/menu_tem.dart';
import 'package:resto_app/widgets/reviewItem.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  final reviewFieldController = TextEditingController();
  final userFieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    reviewFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as RestaurantDetailPageArguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: ApiService().getRestaurant(args.id),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                var restaurantDetail = snapshot.data as RestaurantDetailModel;
                var drinks = restaurantDetail.restaurant.menus.drinks;
                var foods = restaurantDetail.restaurant.menus.foods;
                var reviews = restaurantDetail.restaurant.customerReviews;
                return Column(
                  children: [
                    Hero(
                      tag: restaurantDetail.restaurant.pictureId,
                      child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.restaurant.pictureId}"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurantDetail.restaurant.name,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  restaurantDetail.restaurant.rating.toString(),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                Divider(
                                  indent: 10.0,
                                ),
                                Icon(
                                  Icons.place,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                Text(
                                  restaurantDetail.restaurant.city,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Text(
                            restaurantDetail.restaurant.description,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Divider(),
                          Text(
                            "Foods",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: foods.length,
                              itemBuilder: (context, index) {
                                return MenuItem(category: foods[index]);
                              },
                            ),
                          ),
                          Divider(),
                          Text(
                            "Drinks",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: drinks.length,
                              itemBuilder: (context, index) {
                                return MenuItem(category: drinks[index]);
                              },
                            ),
                          ),
                          Divider(),
                          Text(
                            "Reviews",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                return ReviewItem(
                                    customerReview: reviews, index: index);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8, bottom: 8),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: userFieldController,
                                  decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    border: OutlineInputBorder(),
                                    hintText: "Your name...",
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: reviewFieldController,
                                  decoration: InputDecoration(
                                    fillColor: Theme.of(context).primaryColor,
                                    border: OutlineInputBorder(),
                                    hintText: "Review here...",
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    sendReview(
                                        restaurantDetail.restaurant.id
                                            .toString(),
                                        userFieldController.text,
                                        reviewFieldController.text);
                                  },
                                  icon: Icon(Icons.send_outlined),
                                  label: Text("Send Review"),
                                  style: ElevatedButton.styleFrom(
                                    primary: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Please wait..."),
                    ],
                  ),
                );
              }
              throw Exception("Error Occured --> ${snapshot.error}");
            },
          ),
        ),
      ),
    );
  }

  void sendReview(String id, String username, String review) {
    SnackBar snackBar;
    try {
      if (username != "" && review != "") {
        ApiService().postReview(id, username, review).then((value) {
          if (value.error == false) {
            snackBar = SnackBar(
              content: Text("Review berhasil ditambahkan!"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }).catchError((error) {
          snackBar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      } else {}
    } catch (e) {
      snackBar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
