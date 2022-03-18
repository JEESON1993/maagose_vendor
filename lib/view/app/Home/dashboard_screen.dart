import 'package:maafosrestaurant/component/zeroState.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:maafosrestaurant/component/zerostatepng.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/component/appBarWidget.dart';
import 'package:maafosrestaurant/component/dummy/orderShimmer.dart';
import 'package:maafosrestaurant/component/orderCard.dart';
import 'package:maafosrestaurant/component/statusCard.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/model/AnalysisModel.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController = ScrollController();
  bool isLoading = true;
  AnalysisModel analysis;

  getAnalysis() async {
    var result = await Provider.of<RestaurantProvider>(context, listen: false)
        .restaurantAnalysis();
    if (result != null) {
      setState(() {
        analysis = AnalysisModel.fromJson(result);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  getFCM() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        Provider.of<RestaurantProvider>(context, listen: false)
            .updateFCM(value);
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        Provider.of<RestaurantProvider>(context, listen: false)
            .updateFCM(value);
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    getAnalysis();
    getFCM();
    Provider.of<RestaurantProvider>(context, listen: false).restaurantOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
        context,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return Provider.of<RestaurantProvider>(context, listen: false)
                .refreshAll();
          },
          backgroundColor: Colors.white,
          color: kSecondayColor,
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Consumer<RestaurantProvider>(
                    builder: (context, data, child) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatusCard(
                              status: data.loading,
                              title: "Today's Earnings",
                              count: '₹${data?.analysis?.total?.toDouble()}',
                              icon: "assets/svg/dollar.svg"),
                          StatusCard(
                              status: data.loading,
                              title: "Today's Orders",
                              count: data?.analysis?.order.toString(),
                              icon: "assets/svg/food.svg"),
                        ],
                      ),
                    ),
                  ),
                  Consumer<RestaurantProvider>(
                      builder: (context, data, child) => data.loading
                          ? orderShimmer()
                          : data.restaurant.vendor.storeStatus == true
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10, bottom: 5),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/svg/streaming.svg',
                                            height: (30),
                                            width: (30),
                                            color: kPrimaryColor,
                                          ),
                                          Text(
                                            'Live Orders',
                                            style: kHeadTitleSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Consumer<RestaurantProvider>(
                                        builder: (context, data1, child) =>
                                            Container(
                                              child: data1.loading
                                                  ? orderShimmer()
                                                  : data1.todaysOrders != null
                                                      ? data1.todaysOrders.data
                                                              .isEmpty
                                                          ? Container(
                                                              height: 350,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Lottie.asset(
                                                                    'assets/lottie/searching.json',
                                                                    width: 150,
                                                                    height: 150,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                  Text(
                                                                    'Searching..',
                                                                    style:
                                                                        kHeadTitleSmall,
                                                                  ),
                                                                  Text(
                                                                    'Searching for orders',
                                                                    style:
                                                                        kMediumText,
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : ListView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: data1
                                                                  .todaysOrders
                                                                  .data
                                                                  .length,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var item = data1
                                                                    .todaysOrders
                                                                    .data[index];
                                                                return OrderCard(
                                                                    item: item);
                                                              },
                                                            )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                          strokeWidth: 1,
                                                        )),
                                            )),
                                  ],
                                )
                              : zerostatePng(
                                  size: 200,
                                  height: 400,
                                  icon: 'assets/images/noservice.png',
                                  head: 'Restaurant Off!',
                                  sub:
                                      'Restaurent currently not servicable, Turn on to start accepting orders!')),
                ],
              )),
        ),
      ),
    );
  }
}
