import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/constant/app_constants.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';
import 'package:maafosrestaurant/view/app/Settings/settings_screen.dart';

Widget appBarWidget(BuildContext context,
    {String subitle, String title, bottom}) {
  return AppBar(
      bottom: bottom,
      titleSpacing: 0,
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: kPrimaryColor,
      title: Consumer<RestaurantProvider>(
        builder: (context, data, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (title == null)
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: kPrimaryColorFaded,
                            backgroundImage: data.isGrocery
                                ? NetworkImage(awsUrl +
                                    data.groceryModel.vendor.storeLogo.key)
                                : NetworkImage(awsUrl +
                                    data.restaurant.vendor.storeLogo.key),
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: data.isGrocery
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title != null
                                      ? title
                                      : '${data.groceryModel.vendor.name}',
                                  style: kHeadTitleMediumW,
                                ),
                                Text(
                                  subitle != null
                                      ? subitle
                                      : data
                                          .groceryModel.vendor.location.address,
                                  maxLines: 1,
                                  style: kMediumTextSmallerW,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title != null
                                      ? title
                                      : '${data.restaurant.vendor.name}',
                                  style: kHeadTitleMediumW,
                                ),
                                Text(
                                  subitle != null
                                      ? subitle
                                      : data.restaurant.vendor.location.address,
                                  maxLines: 1,
                                  style: kMediumTextSmallerW,
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              ),
              data.isGrocery
                  ? CupertinoSwitch(
                      activeColor: Colors.white,
                      thumbColor: Colors.black87,
                      value: data.groceryModel.vendor.storeStatus,
                      onChanged: (val) {
                        data.switchStatus(context, val);
                      },
                    )
                  : CupertinoSwitch(
                      activeColor: Colors.white,
                      thumbColor: Colors.black87,
                      value: data.restaurant.vendor.storeStatus,
                      onChanged: (val) {
                        data.switchStatus(context, val);
                      },
                    )
            ],
          ),
        ),
      ));
}
