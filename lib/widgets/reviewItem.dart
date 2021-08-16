import 'package:flutter/material.dart';
import 'package:resto_app/models/restaurant_detail_model.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({required this.customerReview, required this.index});

  final List<CustomerReview> customerReview;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 20,
                ),
                Divider(
                  indent: 5,
                ),
                Text(
                  customerReview[index].name,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
                Divider(
                  indent: 5,
                ),
                Text(
                  customerReview[index].date,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  customerReview[index].review,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
