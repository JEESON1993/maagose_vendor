import 'package:maafosrestaurant/provider/RestaurantProvider.dart';
import 'package:maafosrestaurant/view/app/Order/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:maafosrestaurant/component/rowItem.dart';
import 'package:maafosrestaurant/helper/string_extension.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/model/OrderCardModel.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatelessWidget {
  final Datum item;
  const OrderCard({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getmodel = Provider.of<RestaurantProvider>(context, listen: false);
    var outputDate = (date) => DateFormat('d MMM yy, hh:mm a')
        .format(DateTime.parse(date).toUtc().toLocal());

    return GestureDetector(
      onTap: () {
        print(item.id);
        return Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailScreen(
                    id: item.id,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.7, color: kGreyLighter),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.customer.name,
                        style: kBoldTextLarge,
                      ),
                      Text(
                        '${item.orderStatus}'.capitalizeAll,
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w700,
                            color: item.orderStatus == 'delivered'
                                ? kSecondayColor
                                : item.orderStatus == 'cancelled'
                                    ? Colors.red[900]
                                    : kPrimaryColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${outputDate(item.createdAt.toString())}'),
                        Text(
                          '${item.orderId}',
                          style: kBoldTextMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/bag.svg",
                        height: 20,
                        width: 20,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'ITEMS',
                        style: kBoldTextLarge,
                      ),
                    ],
                  ),
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
                        '${item.items.length}',
                        style: kBoldTextMediumW,
                      )),
                ],
              ),
            ),
            ...item.items
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: rowItem(
                          title: '${e.name}',
                          price: e.price,
                          count: e.qty,
                          bold: true),
                    ))
                .toList(),
            Divider(
              height: 2,
            ),
            Offstage(
              offstage: item.orderStatus != 'preparing',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSecondayColor,
                      elevation: 0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(3),
                      ),
                    ),
                    onPressed: () =>
                        getmodel.updateOrderStatus(context, 'ready', item.id),
                    child: Text('Ready for pickup')),
              ),
            ),
            Offstage(
              offstage: item.orderStatus != 'placed',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                          onPressed: () => getmodel.updateOrderStatus(
                              context, 'cancelled', item.id),
                          style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.red[100])),
                          icon: Icon(
                            Icons.close,
                            color: Colors.red[900],
                          ),
                          label: Text(
                            'Decline',
                            style: TextStyle(color: Colors.red[900]),
                          )),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kSecondayColor,
                              elevation: 0,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(3),
                              ),
                            ),
                            onPressed: () {
                              print(item.orderId);
                              print(item.id);
                              getmodel.updateOrderStatus(
                                  context, 'accepted', item.id);
                            },
                            child: Text('Accept')))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
