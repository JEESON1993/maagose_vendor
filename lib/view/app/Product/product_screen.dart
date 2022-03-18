// ignore_for_file: unused_import

import 'dart:convert';

import 'package:maafosrestaurant/component/dummy/orderShimmer.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maafosrestaurant/component/appBarWidget.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/model/ProductsModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:maafosrestaurant/helper/string_extension.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  getCategory() async {
    Provider.of<RestaurantProvider>(context, listen: false)
        .restaurantCategory(context);
  }

  Future switchCategoryStatus(status, id) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Cookie': 'token=$token'
    };
    var request = http.Request(
        'PUT', Uri.parse('https://maafos.live/api/v1/vendor/category?id=$id'));
    request.body = json.encode({"status": status});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      getCategory();
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future switchProductStatus(status, id) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    var headers = {'Authorization': 'Bearer $token', 'Cookie': 'token=$token'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://maafos.live/api/v1/product/list?productId=$id&status=$status'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      getCategory();
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  // switchProductStatus(status, id, type) async {
  //   Provider.of<RestaurantProvider>(context, listen: false)
  //       .switchProductStatus(context, status, type, id);
  // }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(context,
          title: 'Products List', subitle: 'Restaurant category & products'),
      body: Consumer<RestaurantProvider>(
        builder: (context, data, child) => data.products == null
            ? orderShimmer()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: data.products.products.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var item = data.products.products[index];
                  return Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x18818181),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ],
                        border: Border()),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 5),
                                      width: 30,
                                      height: 30,
                                      alignment: Alignment.center,
                                      decoration: new BoxDecoration(
                                        color: kPrimaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        item.category.products.length
                                            .toString(),
                                        style: kBoldTextMediumW,
                                      )),
                                  Text(
                                    item.category.name.capitalizeAll,
                                    style: kBoldTextLarge,
                                  ),
                                ],
                              ),
                              Switch(
                                inactiveTrackColor: Colors.red[100],
                                inactiveThumbColor: Colors.red[900],
                                activeColor: kSecondayColor,
                                value: item.category.vendorCategoryStatus,
                                onChanged: (val) => switchCategoryStatus(
                                    val, item.category.vendorCategory),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 0,
                          color: kGreyLight,
                        ),
                        ...item.category.products
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 35,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e.name,
                                                style: kMediumText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Switch(
                                          inactiveTrackColor: Colors.red[100],
                                          inactiveThumbColor: Colors.red[900],
                                          activeColor: kSecondayColor,
                                          value: e.status,
                                          onChanged: (val) =>
                                              switchProductStatus(
                                                val,
                                                e.id,
                                              ))
                                    ],
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
