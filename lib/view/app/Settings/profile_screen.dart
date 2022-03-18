import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:maafosrestaurant/constant/app_constants.dart';
import 'package:maafosrestaurant/constant/color_constants.dart';
import 'package:maafosrestaurant/constant/style_constants.dart';
import 'package:maafosrestaurant/provider/RestaurantProvider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String version;
  versionFetch() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    versionFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var outputDate =
        (date) => DateFormat('hh:mma').format(DateFormat('HH:mm').parse(date));
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.white,
        ),
        title: Text(
          'Profile',
          style: kHeadTitleSmallW,
        ),
      ),
      body: SafeArea(
        child: Consumer<RestaurantProvider>(
          builder: (context, data, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                          data.isGrocery?
                           NetworkImage(
                            awsUrl + data.groceryModel.vendor.storeLogo.key,
                          ):NetworkImage(
                            awsUrl + data.restaurant.vendor.storeLogo.key,
                          ),
                          ),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image:data.isGrocery? NetworkImage(
                                awsUrl + data.groceryModel.vendor.storeLogo.key):NetworkImage(
                                awsUrl + data.restaurant.vendor.storeLogo.key),
                          ),
                          border: Border.all(color: Colors.white, width: 4.0)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                child: data.isGrocery? 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.groceryModel.vendor.name,
                      style: kHeadTitle,
                    ),
                    Text(
                      data.groceryModel.vendor.location.address,
                      style: kHintStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/stopwatch.svg',
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                ' ' + outputDate(data.groceryModel.vendor.openTime),
                                style: kMediumText,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                            child: Text(' - '),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/stopwatch.svg',
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                ' ' + outputDate(data.groceryModel.vendor.closeTime),
                                style: kMediumText,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ):
               Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.restaurant.vendor.name,
                      style: kHeadTitle,
                    ),
                    Text(
                      data.restaurant.vendor.location.address,
                      style: kHintStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/stopwatch.svg',
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                ' ' + outputDate(data.restaurant.vendor.openTime),
                                style: kMediumText,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                            child: Text(' - '),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/stopwatch.svg',
                                height: 15,
                                width: 15,
                              ),
                              Text(
                                ' ' + outputDate(data.restaurant.vendor.closeTime),
                                style: kMediumText,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              
              ),
              Container(
                margin: EdgeInsets.all(10),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x09000000),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset('assets/images/mLogo.png')),
              Text(
                'Version $version',
                style: kHintStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
