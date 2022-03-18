// ignore_for_file: unused_import

import 'package:maafosrestaurant/component/zeroState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maafosrestaurant/component/zerostatepng.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/component/appBarWidget.dart';
import 'package:maafosrestaurant/component/dummy/orderShimmer.dart';
import 'package:maafosrestaurant/component/orderCard.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/model/OrderCardModel.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: appBarWidget(context),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.all(10),
                labelStyle: kMediumTextSmall,
                unselectedLabelColor: kGreyLight,
                enableFeedback: true,
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: kSecondayColor,
                tabs: [
                  Tab(
                    text: 'Completed Orders',
                  ),
                  Tab(
                    text: 'Declined Orders',
                  )
                ],
              ),
              Expanded(
                  flex: 1,
                  child: TabBarView(children: [
                    OrdersTab(type: 'completed'),
                    OrdersTab(type: 'cancelled')
                  ]))
            ],
          )),
    );
  }
}

class OrdersTab extends StatefulWidget {
  final type;
  const OrdersTab({
    Key key,
    String this.type,
  }) : super(key: key);

  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  int page = 0;
  bool isPagination = false;
  ScrollController _scrollController = ScrollController();
  bool isLoading = true;

  getOrders(type) async {
    var res = await Provider.of<RestaurantProvider>(context, listen: false)
        .restaurantPastOrders(type, page, false);
    setState(() {
      isPagination = res['pagination']['next'] != null ? true : false;
      page = res['pagination']['next'] != null ? page + 1 : page;
    });
  }

  getMoreOrders(type) async {
    var res = await Provider.of<RestaurantProvider>(context, listen: false)
        .restaurantPastOrders(type, page, true);
    setState(() {
      isPagination = res['pagination']['next'] != null ? true : false;
      page = res['pagination']['next'] != null ? page + 1 : page;
    });
  }

  @override
  void initState() {
    getOrders(widget.type);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (isPagination) getMoreOrders(widget.type);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, data, child) => data.loading
          ? orderShimmer()
          : data.orders.length == 0
              ? zerostatePng(
                  size: 180,
                  height: 450,
                  icon: 'assets/images/noorder.png',
                  head: 'Swoosh!',
                  sub:
                      'You have no ${widget.type == "cancelled" ? "declined orders" : "completed orders"}')
              : ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: data.orders.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var item = data.orders[index];
                    return OrderCard(item: item);
                  },
                ),
    );
  }
}
