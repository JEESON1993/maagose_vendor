import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';

Widget orderDeatilShimmer() {
  return Shimmer.fromColors(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 20,
              width: 200,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 20,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.all(10),
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      baseColor: kGreyLightest,
      highlightColor: kGreyLighter);
}
