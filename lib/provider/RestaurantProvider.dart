// ignore_for_file: missing_required_param

import 'dart:convert';
import 'dart:io';
import 'package:maafosrestaurant/model/OrderSingleModel.dart';
import 'package:maafosrestaurant/model/PaymentModel.dart';
import 'package:maafosrestaurant/model/ProductsModel.dart';
import 'package:maafosrestaurant/model/groceryModel.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:maafosrestaurant/component/snackBar.dart';
import 'package:maafosrestaurant/constant/app_constants.dart';
import 'package:maafosrestaurant/model/AnalysisModel.dart';
import 'package:maafosrestaurant/model/OrderCardModel.dart';
// import 'package:maafosrestaurant/model/ProductsModel.dart';
import 'package:maafosrestaurant/model/RestaurantModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:maafosrestaurant/view/app/bottom_navigation.dart';
import 'package:maafosrestaurant/view/auth/Login/login_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RestaurantProvider extends ChangeNotifier {
  bool loading = true;
  bool isGrocery = false;
  OrderCardModel todaysOrders;
  OrderSingleModel singelOrder;
  SettlementModel paymantModel;
  List<Datum> orders = [];
  ProductsModel products;
  AnalysisModel analysis = AnalysisModel(
    order: 0,
    total: 0,
  );
  final storage = new FlutterSecureStorage();
  RestaurantModel restaurant = RestaurantModel();
  GroceryModel groceryModel = GroceryModel();
  IO.Socket socket;

  //* CONNECT BRANCH SOCKET
  // _connectSocket(id, BuildContext context) {
  //   socket = IO.io(socketUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect(
  //     (data) => socket.emit('join', 'restaurant_$id'),
  //   );
  //   socket.onConnect(
  //     (data) => print('connected'),
  //   );
  //   socket.on('newOrder', (data) {
  //     if (data["status"] == 'created') {
  //       HapticFeedback.heavyImpact();
  //       restaurantOrders();
  //       return playLocalAsset("sound4.mp3");
  //     }
  //   });
  //   socket.on('orderUpdate', (data) {
  //     if (data["status"] == 'update') {
  //       HapticFeedback.heavyImpact();
  //       restaurantOrders();
  //       return playLocalAsset("sound3.mp3");
  //     }
  //     if (data["status"] == 'complete') {
  //       HapticFeedback.heavyImpact();
  //       restaurantAnalysis();
  //       restaurantOrders();
  //       restaurantPastOrders('delivered', 0, false);
  //       return playLocalAsset("sound3.mp3");
  //     }
  //   });
  // }

  Future changePassword(BuildContext context, body) async {
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/restaurant/password");
    final response = await http.put(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      Navigator.pop(context);
      return showSnackBar(
          context: context, message: 'Password Changed Successfully');
    }
    showSnackBar(context: context, message: 'Something went wrong');
  }

  Future checkUpdate(
    context,
  ) async {
    final Uri url = Uri.https(baseUrl, apiUrl + "/branch/appversion",
        {"app": "restaurant", "platform": Platform.operatingSystem.toString()});
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    var jsonData = jsonDecode(response.body);
    return jsonData["data"];
  }

  Future updateFCM(fcmtoken) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(
      baseUrl,
      apiUrl + "/restaurant/me",
    );
    final response =
        await http.put(url, body: jsonEncode({"fcmToken": fcmtoken}), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('FCM UPDATED');
    }
  }

  Future<AudioPlayer> playLocalAsset(val) async {
    AudioCache cache = new AudioCache();
    return await cache.play(val);
  }

  Future loginUser(BuildContext context, body) async {
    RestaurantModel result;
    // final Uri url = Uri.https(baseUrl, apiUrl + "/auth/login");
    final Uri url = Uri.https(baseUrl, apiUrl + "/auth/user-login");
    final response = await http.post(url, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 401) {
      return showSnackBar(context: context, message: data['message']['error']);
    }

    if (response.statusCode == 200) {
      await storage.write(key: "token", value: data["token"]);
      return dataMe(context, data["token"]);
    }
    showSnackBar(context: context, message: 'Something went wrong');
    return result;
  }

  Future<RestaurantModel> dataMe(BuildContext context, token) async {
    RestaurantModel result;
    // final Uri url = Uri.https(baseUrl, apiUrl + "/restaurant/me");
    final Uri url = Uri.https(baseUrl, apiUrl + "/vendor/me");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // _connectSocket(data["restaurant"]["_id"], context);
      data['vendor']['type'] == 'grocery'
          ? isGrocery = true
          : isGrocery = false;
      data['vendor']['type'] == 'grocery'
          ? groceryModel = GroceryModel.fromJson(data)
          : restaurant = RestaurantModel.fromJson(data);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(),
          ),
          (_) => false);
    } else if (response.statusCode == 401) {
      await storage.delete(key: 'token');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (_) => false);
    } else {
      await storage.delete(key: 'token');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
          (_) => false);
    }
    return result;
  }

  Future switchStatus(BuildContext context, status) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/vendor/status",
        {"type": "vendor", "status": status.toString()});
    final response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isGrocery
          ? groceryModel.vendor.storeStatus = status
          : restaurant.vendor.storeStatus = status;
      showSnackBar(context: context, message: data["message"]);
      if (status) {
        restaurantOrders();
      }
      return notifyListeners();
    }
    if (response.statusCode == 401) {
      showSnackBar(context: context, message: 'Something went wrong');
    }
  }

  Future restaurantAnalysis() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(
      baseUrl,
      apiUrl + "/vendor/analysis",
    );
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      analysis = AnalysisModel.fromJson(data["data"]);
      loading = false;
    }
  }

  // Future updateOrderStatus(
  //     BuildContext context, String type, String oid) async {
  //   String token = await storage.read(key: "token");
  //   final Uri url = Uri.https(
  //       baseUrl, apiUrl + "/order/vendor/order?orderId=$oid&type=$type");
  //   final response = await http.put(url,  headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //         print(response.body);

  //   if (response.statusCode == 200) {
  //     loading = false;
  //     restaurantOrders();
  //   } else {
  //     loading = false;
  //   }
  //   notifyListeners();
  // }

  Future updateOrderStatus(
      BuildContext context, String type, String oid) async {
    String token = await storage.read(key: "token");
    print(token);
    var headers = {'Authorization': 'Bearer $token', 'Cookie': 'token=$token'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://maafos.live/api/v1/order/vendor/order?orderId=$oid&type=$type'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      restaurantOrders();
      loading = false;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      showSnackBar(context: context, message: 'delivery boy not assigned');
      loading = false;
    }
    notifyListeners();
  }

  Future restaurantOrders() async {
    loading = true;
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");

    final Uri url =
        Uri.https(baseUrl, apiUrl + "/order/vendor/status", {"type": "today"});
    // final Uri url = Uri.https(
    //     baseUrl, apiUrl + "/order/restaurant/status", {"type": 'today'});
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      todaysOrders = OrderCardModel.fromJson(data);
      loading = false;
    } else {
      loading = false;
    }
    notifyListeners();
  }

  Future restaurantCanOrders() async {
    loading = true;
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");

    final Uri url = Uri.https(
        baseUrl, apiUrl + "/order/vendor/status", {"type": 'cancelled'});
    // final Uri url = Uri.https(
    //     baseUrl, apiUrl + "/order/restaurant/status", {"type": 'today'});
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      todaysOrders = OrderCardModel.fromJson(data);
      loading = false;
    } else {
      loading = false;
    }
    notifyListeners();
  }

  Future restaurantPastOrders(type, page, loadmore) async {
    loading = true;
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/order/vendor/status", {
      "type": type.toString(),
      "page": (page + 1).toString(),
      "limit": '10'
    });
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      loading = false;
      if (loadmore)
        orders = orders +
            List<Datum>.from(data["data"].map((x) => Datum.fromJson(x)));
      else
        orders = List<Datum>.from(data["data"].map((x) => Datum.fromJson(x)));
      return data;
    }
    notifyListeners();
  }

  Future restaurantCategory(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/product/list");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      products = ProductsModel.fromJson(data);

      return notifyListeners();
    } else {
      print('something went wrong');
    }
    return showSnackBar(context: context, message: 'Something went wrong');
  }

  // Future switchCategoryStatus(BuildContext context, status, type, id) async {
  //   final storage = new FlutterSecureStorage();
  //   String token = await storage.read(key: "token");
  //   final Uri url = Uri.https(baseUrl, apiUrl + "/restaurant/status", {
  //     "type": type.toString(),
  //     "id": id.toString(),
  //     "status": status.toString()
  //   });
  //   final response = await http.put(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   var data = jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     showSnackBar(context: context, message: data["message"]);
  //     return restaurantCategory(context);
  //   }
  //   if (response.statusCode == 401) {
  //     showSnackBar(context: context, message: 'Something went wrong');
  //   }
  //   notifyListeners();
  // }
  //
  Future switchProductStatus(BuildContext context, status, type, id) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(
        baseUrl, apiUrl + "/product/list?productId=$id&status=$status");
    final response = await http.put(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showSnackBar(context: context, message: 'data updated');
      return restaurantCategory(context);
    }
    if (response.statusCode == 401) {
      showSnackBar(context: context, message: 'Something went wrong');
    }
    notifyListeners();
  }

  Future refreshAll() async {
    loading = true;
    restaurantAnalysis();
    restaurantOrders();
    notifyListeners();
  }

  Future getSingleOrder(String oid) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/order/$oid");
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      singelOrder = OrderSingleModel.fromJson(data);

      return data;
    } else {
      print('something wrong');
    }
  }

  Future getSettlement(BuildContext context, from, to, page) async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "token");
    final Uri url = Uri.https(baseUrl, apiUrl + "/settlement/vendor", {
      "from": from.toString(),
      "to": to.toString(),
      "page": (page + 1).toString(),
      "limit": '10'
    });
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var data = jsonDecode(response.body);

    return data;
  }
  // Future<SettlementModel> getSettlement(
  //     BuildContext context, from, to, page) async {
  //   loading = true;
  //   final storage = new FlutterSecureStorage();
  //   String token = await storage.read(key: "token");
  //   final Uri url = Uri.https(baseUrl, apiUrl + "/settlement/vendor", {
  //     "from": from.toString(),
  //     "to": to.toString(),
  //     "page": (page + 1).toString(),
  //     "limit": '10'
  //   });
  //   final response = await http.get(url, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   var data = jsonDecode(response.body);

  //   if (response.statusCode == 200) {
  //     print(response.body);

  //     paymantModel = SettlementModel.fromJson(data);
  //     loading = false;
  //   } else {
  //     print('something went wrong');
  //   }
  //   return data;
  // }
}
