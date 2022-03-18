// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
    RestaurantModel({
        @required this.success,
        @required this.vendor,
    });

    final bool success;
    final Vendor vendor;

    factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        success: json["success"] == null ? null : json["success"],
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "vendor": vendor == null ? null : vendor.toJson(),
    };
}

class Vendor {
    Vendor({
        @required this.storeLogo,
        @required this.storeBg,
        @required this.location,
        @required this.contactNumber,
        @required this.quickDelivery,
        @required this.storeStatus,
        @required this.addons,
        @required this.featured,
        @required this.rating,
        @required this.minimumOrderValue,
        @required this.id,
        @required this.name,
        @required this.branch,
        @required this.type,
        @required this.openTime,
        @required this.closeTime,
        @required this.cuisine,
        @required this.commission,
        @required this.dCommission,
        @required this.sortOrder,
        @required this.avgCookingTime,
        @required this.avgPersonAmt,
        @required this.user,
        @required this.storeBanner,
        @required this.category,
        @required this.createdAt,
        @required this.updatedAt,
        @required this.v,
    });

    final Store storeLogo;
    final Store storeBg;
    final VendorLocation location;
    final dynamic contactNumber;
    final bool quickDelivery;
     bool storeStatus;
    final List<dynamic> addons;
    final bool featured;
    final double rating;
    final dynamic minimumOrderValue;
    final String id;
    final String name;
    final Branch branch;
    final String type;
    final String openTime;
    final String closeTime;
    final String cuisine;
    final dynamic commission;
    final dynamic dCommission;
    final dynamic sortOrder;
    final dynamic avgCookingTime;
    final dynamic avgPersonAmt;
    final User user;
    final List<dynamic> storeBanner;
    final List<Category> category;
    final String createdAt;
    final String updatedAt;
    final dynamic v;

    factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        storeLogo: json["storeLogo"] == null ? null : Store.fromJson(json["storeLogo"]),
        storeBg: json["storeBg"] == null ? null : Store.fromJson(json["storeBg"]),
        location: json["location"] == null ? null : VendorLocation.fromJson(json["location"]),
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
        quickDelivery: json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        addons: json["addons"] == null ? null : List<dynamic>.from(json["addons"].map((x) => x)),
        featured: json["featured"] == null ? null : json["featured"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        minimumOrderValue: json["minimumOrderValue"] == null ? null : json["minimumOrderValue"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        cuisine: json["cuisine"] == null ? null : json["cuisine"],
        commission: json["commission"] == null ? null : json["commission"],
        dCommission: json["dCommission"] == null ? null : json["dCommission"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        avgCookingTime: json["avgCookingTime"] == null ? null : json["avgCookingTime"],
        avgPersonAmt: json["avgPersonAmt"] == null ? null : json["avgPersonAmt"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        storeBanner: json["storeBanner"] == null ? null : List<dynamic>.from(json["storeBanner"].map((x) => x)),
        category: json["category"] == null ? null : List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "storeLogo": storeLogo == null ? null : storeLogo.toJson(),
        "storeBg": storeBg == null ? null : storeBg.toJson(),
        "location": location == null ? null : location.toJson(),
        "contactNumber": contactNumber == null ? null : contactNumber,
        "quickDelivery": quickDelivery == null ? null : quickDelivery,
        "storeStatus": storeStatus == null ? null : storeStatus,
        "addons": addons == null ? null : List<dynamic>.from(addons.map((x) => x)),
        "featured": featured == null ? null : featured,
        "rating": rating == null ? null : rating,
        "minimumOrderValue": minimumOrderValue == null ? null : minimumOrderValue,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "branch": branch == null ? null : branch.toJson(),
        "type": type == null ? null : type,
        "openTime": openTime == null ? null : openTime,
        "closeTime": closeTime == null ? null : closeTime,
        "cuisine": cuisine == null ? null : cuisine,
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "avgCookingTime": avgCookingTime == null ? null : avgCookingTime,
        "avgPersonAmt": avgPersonAmt == null ? null : avgPersonAmt,
        "user": user == null ? null : user.toJson(),
        "storeBanner": storeBanner == null ? null : List<dynamic>.from(storeBanner.map((x) => x)),
        "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
    };
}

class Branch {
    Branch({
        @required this.location,
        @required this.id,
        @required this.name,
        @required this.supportNumber,
    });

    final BranchLocation location;
    final String id;
    final String name;
    final dynamic supportNumber;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        location: json["location"] == null ? null : BranchLocation.fromJson(json["location"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        supportNumber: json["supportNumber"] == null ? null : json["supportNumber"],
    );

    Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "supportNumber": supportNumber == null ? null : supportNumber,
    };
}

class BranchLocation {
    BranchLocation({
        @required this.address,
    });

    final String address;

    factory BranchLocation.fromJson(Map<String, dynamic> json) => BranchLocation(
        address: json["address"] == null ? null : json["address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address == null ? null : address,
    };
}

class Category {
    Category({
        @required this.status,
        @required this.id,
        @required this.category,
    });

    final bool status;
    final String id;
    final String category;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null ? null : json["category"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "category": category == null ? null : category,
    };
}

class VendorLocation {
    VendorLocation({
        @required this.type,
        @required this.formattedAddress,
        @required this.address,
        @required this.coordinates,
        @required this.landmark,
    });

    final String type;
    final String formattedAddress;
    final String address;
    final List<double> coordinates;
    final String landmark;

    factory VendorLocation.fromJson(Map<String, dynamic> json) => VendorLocation(
        type: json["type"] == null ? null : json["type"],
        formattedAddress: json["formattedAddress"] == null ? null : json["formattedAddress"],
        address: json["address"] == null ? null : json["address"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        landmark: json["landmark"] == null ? null : json["landmark"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "address": address == null ? null : address,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x)),
        "landmark": landmark == null ? null : landmark,
    };
}

class Store {
    Store({
        @required this.key,
        @required this.image,
    });

    final String key;
    final String image;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        key: json["key"] == null ? null : json["key"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "image": image == null ? null : image,
    };
}

class User {
    User({
        @required this.id,
        @required this.username,
    });

    final String id;
    final String username;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        username: json["username"] == null ? null : json["username"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "username": username == null ? null : username,
    };
}
