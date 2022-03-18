// To parse this JSON data, do
//
//     final orderCardModel = orderCardModelFromJson(jsonString);

import 'dart:convert';

OrderCardModel orderCardModelFromJson(String str) =>
    OrderCardModel.fromJson(json.decode(str));

String orderCardModelToJson(OrderCardModel data) => json.encode(data.toJson());

class OrderCardModel {
  OrderCardModel({
    this.data,
  });

  List<Datum> data;

  factory OrderCardModel.fromJson(Map<String, dynamic> json) => OrderCardModel(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.orderStatus,
    this.customer,
    this.totalAmount,
    this.vendorId,
    this.items,
    this.address,
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  String id;
  String type;
  String orderStatus;
  Customer customer;
  dynamic totalAmount;
  VendorId vendorId;
  List<Item> items;
  DatumAddress address;
  String orderId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        type: json["type"] == null ? null : json["type"],
        orderStatus: json["orderStatus"] == null ? null : json["orderStatus"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        vendorId: json["vendorId"] == null
            ? null
            : VendorId.fromJson(json["vendorId"]),
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        address: json["address"] == null
            ? null
            : DatumAddress.fromJson(json["address"]),
        orderId: json["orderId"] == null ? null : json["orderId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "type": type == null ? null : type,
        "orderStatus": orderStatus == null ? null : orderStatus,
        "customer": customer == null ? null : customer.toJson(),
        "totalAmount": totalAmount == null ? null : totalAmount,
        "vendorId": vendorId == null ? null : vendorId.toJson(),
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "address": address == null ? null : address.toJson(),
        "orderId": orderId == null ? null : orderId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class DatumAddress {
  DatumAddress({
    this.coordinates,
    this.name,
    this.landmark,
    this.location,
  });

  List<double> coordinates;
  String name;
  String landmark;
  String location;

  factory DatumAddress.fromJson(Map<String, dynamic> json) => DatumAddress(
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        name: json["name"] == null ? null : json["name"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        location: json["location"] == null ? null : json["location"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "name": name == null ? null : name,
        "landmark": landmark == null ? null : landmark,
        "location": location == null ? null : location,
      };
}

class Customer {
  Customer({
    this.name,
  });

  String name;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class Item {
  Item({
    this.addons,
    this.id,
    this.name,
    this.price,
    this.meal,
    this.offerPrice,
    this.fagoPrice,
    this.qty,
    this.qtyType,
    this.count,
  });

  List<dynamic> addons;
  String id;
  String name;
  dynamic price;
  String meal;
  dynamic offerPrice;
  dynamic fagoPrice;
  dynamic qty;
  dynamic qtyType;
  dynamic count;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        addons: json["addons"] == null
            ? null
            : List<dynamic>.from(json["addons"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        meal: json["meal"] == null ? null : json["meal"],
        offerPrice: json["offerPrice"] == null ? null : json["offerPrice"],
        fagoPrice: json["fagoPrice"] == null ? null : json["fagoPrice"],
        qty: json["qty"],
        qtyType: json["qtyType"],
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "addons":
            addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "meal": meal == null ? null : meal,
        "offerPrice": offerPrice == null ? null : offerPrice,
        "fagoPrice": fagoPrice == null ? null : fagoPrice,
        "qty": qty,
        "qtyType": qtyType,
        "count": count == null ? null : count,
      };
}

class VendorId {
  VendorId({
    this.address,
    this.name,
  });

  VendorIdAddress address;
  String name;

  factory VendorId.fromJson(Map<String, dynamic> json) => VendorId(
        address: json["address"] == null
            ? null
            : VendorIdAddress.fromJson(json["address"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "address": address == null ? null : address.toJson(),
        "name": name == null ? null : name,
      };
}

class VendorIdAddress {
  VendorIdAddress({
    this.type,
    this.coordinates,
    this.location,
  });

  String type;
  List<double> coordinates;
  String location;

  factory VendorIdAddress.fromJson(Map<String, dynamic> json) =>
      VendorIdAddress(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        location: json["location"] == null ? null : json["location"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates.map((x) => x)),
        "location": location == null ? null : location,
      };
}
