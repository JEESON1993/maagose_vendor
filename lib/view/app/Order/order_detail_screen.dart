// ignore_for_file: unused_import

import 'package:maafosrestaurant/model/OrderSingleModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/component/dummy/orderDetailShimmer.dart';
import 'package:maafosrestaurant/component/rowItem.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/helper/string_extension.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';

class OrderDetailScreen extends StatefulWidget {
  final String id;
  OrderDetailScreen({Key key, this.id}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = true;
  OrderSingleModel order;
  getSingleOrder(id,) async {
    setState(() {
      isLoading = true;
    });
    var res = await Provider.of<RestaurantProvider>(context, listen: false)
        .getSingleOrder(id);
    if (res != null)
      setState(() {
        isLoading = false;
        order = OrderSingleModel.fromJson(res);
      });
    else
      setState(() {
        isLoading = false;
      });
  }

  @override
  void initState() {
    super.initState();
    getSingleOrder(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var outputDate = (date) => DateFormat('d MMM yy, hh:mm a')
        .format(DateTime.parse(date).toUtc().toLocal());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => getSingleOrder(widget.id),
          backgroundColor: Colors.white,
          color: kSecondayColor,
          child: SingleChildScrollView(
            child: isLoading
                ? orderDeatilShimmer()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
        ),
        title:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${order.data.orderStatus ?? 'Loading'}'.capitalizeAll,
              style: kHeadTitleSmallW,
            ),
            Text(
              isLoading
                  ? 'Loading'
                  : '${order.data.orderStatus}, ${order.data.items.length} Items, ₹${order.data.totalAmount.toDouble()}'
                      .capitalise,
              style: kMediumTextSmallerW,
            ),
          ],
        ),
      ),
                      // if (order?.orderStatus != 'delivered' &&
                      //     order?.delay?.type != null)
                      //   Container(
                      //       decoration: ShapeDecoration(
                      //         color: Color(0xFFFAF6F0),
                      //         shape: ContinuousRectangleBorder(
                      //             borderRadius: BorderRadius.circular(20),
                      //             side: BorderSide(
                      //                 width: 1, color: Color(0xFFF39D1C))),
                      //       ),
                      //       margin: EdgeInsets.all(10),
                      //       padding: EdgeInsets.all(10),
                      //       height: 60,
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             "assets/svg/complain.svg",
                      //             height: 30,
                      //             width: 30,
                      //           ),
                      //           SizedBox(
                      //             width: 10,
                      //           ),
                      //           Column(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text('${order?.delay?.type}'.capitalizeAll,
                      //                   style: kMediumTextSmall),
                      //               Text('${order?.delay?.reason}'.capitalise,
                      //                   style: kMediumTextSmaller)
                      //             ],
                      //           ),
                      //         ],
                      //       )),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'ORDER ID ${order.data.orderId}',
                              style: kBoldTextMedium,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('${outputDate(order.data.createdAt.toString())}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ITEMS',
                              style: kBoldTextMedium,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ...order.data.items
                                .map((e) => rowItem(
                                    title: '${e.name}',
                                    price: e.price * e.qty,
                                    count: e.qty,
                                    bold: false))
                                .toList(),
                            Divider(),
                            // rowItem(
                            //     title: 'Packing Charge',
                            //     price: order.totalPackingAmount,
                            //     bold: false),
                            Divider(),
                            rowItem(
                              title: 'Total Amount',
                              price: order.data.vendorTotalAmount,
                            ),
                            rowItem(
                              title: 'Commission',
                              price: order.data.commissionDetail.commissionAmount,
                            ),
                            Divider(),
                            rowItem(
                                title: 'Receivable Amount',
                                titleBold: true,
                                price: order.data.vendorCommissionTotal,
                                bold: true),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// Future<void> _showDelayDialog(
//     BuildContext context, OrderSingleModel item, callBack) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       String delayType;
//       TextEditingController reasonController = new TextEditingController();
//       var getmodel = Provider.of<RestaurantProvider>(context, listen: false);
//       delayOrder() {
//         String reason = reasonController.text.trim();
//         delaySwitch(type) {
//           switch (type) {
//             case 'high traffic':
//               return {
//                 "type": type,
//                 "reason": 'due to heavy traffic in city.',
//               };
//               break;
//             case 'rain':
//               return {
//                 "type": type,
//                 "reason": 'due to heavy rain in city.',
//               };
//               break;
//             case 'restaurant delay':
//               return {
//                 "type": type,
//                 "reason": 'due to restaurant rush.',
//               };
//               break;
//             case 'others':
//               return {
//                 "type": type,
//                 "reason": reason,
//               };
//               break;
//             default:
//           }
//         }

//         getmodel.addDelay(context, item.id, delaySwitch(delayType));
//         callBack(item.id);
//         Navigator.of(context).pop();
//       }

//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             insetPadding: EdgeInsets.all(15),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             scrollable: true,
//             titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//             contentPadding: EdgeInsets.zero,
//             title: Text(
//               'Reason for delay',
//               style: kHeadTitleMedium,
//             ),
//             content: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
//                 child: ListBody(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: Text(
//                         'Please select the reson for delay on this order',
//                         style: kMediumTextSmall,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 20,
//                             margin: EdgeInsets.only(right: 10),
//                             child: Radio(
//                               value: 'high traffic',
//                               groupValue: delayType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   delayType = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('High Traffic')
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 20,
//                             margin: EdgeInsets.only(right: 10),
//                             child: Radio(
//                               value: 'rain',
//                               groupValue: delayType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   delayType = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Rain')
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 20,
//                             margin: EdgeInsets.only(right: 10),
//                             child: Radio(
//                               value: 'restaurant delay',
//                               groupValue: delayType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   delayType = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Restaurant Delay')
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 20,
//                             height: 20,
//                             margin: EdgeInsets.only(right: 10),
//                             child: Radio(
//                               value: 'others',
//                               groupValue: delayType,
//                               onChanged: (value) {
//                                 setState(() {
//                                   delayType = value;
//                                 });
//                               },
//                             ),
//                           ),
//                           Text('Others')
//                         ],
//                       ),
//                     ),
//                     if (delayType == 'others')
//                       TextFormField(
//                         controller: reasonController,
//                         style: kMediumText,
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                         decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey[140],
//                             border: kOutlineStyle,
//                             hintText: 'Specify your reason for delay',
//                             hintStyle: kHintStyle),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Close'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: Text('Submit'),
//                 onPressed: () => delayOrder(),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }


