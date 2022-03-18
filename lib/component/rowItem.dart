// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';

Widget rowItem({title, price, bold, count = null, titleBold = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              if (count != null)
                Text(
                  '$count x ',
                  style: kHeadTitleSmall,
                ),
              Expanded(
                child: Text(
                  title,
                  style: titleBold ? kBoldTextMedium : kMediumTextSmall,
                ),
              ),
            ],
          ),
        ),
        Text(
          '₹${price?.toStringAsFixed(2)}',
          style: bold == true ? kBoldTextMedium : kHintStyleSmall,
        )
      ],
    ),
  );
}
