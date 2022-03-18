// To parse this JSON data, do
//
//     final groceryModel = groceryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GroceryModel groceryModelFromJson(String str) => GroceryModel.fromJson(json.decode(str));

String groceryModelToJson(GroceryModel data) => json.encode(data.toJson());

class GroceryModel {
    GroceryModel({
        @required this.success,
        @required this.vendor,
    });

    final bool success;
    final Vendor vendor;

    factory GroceryModel.fromJson(Map<String, dynamic> json) => GroceryModel(
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
        @required this.commission,
        @required this.dCommission,
        @required this.sortOrder,
        @required this.gst,
        @required this.fssai,
        @required this.user,
        @required this.storeBanner,
        @required this.category,
        @required this.createdAt,
        @required this.updatedAt,
        @required this.v,
        @required this.fcmToken,
    });

    final StoreBg storeLogo;
    final StoreBg storeBg;
    final VendorLocation location;
    final dynamic contactNumber;
    final bool quickDelivery;
     bool storeStatus;
    final List<dynamic> addons;
    final bool featured;
    final dynamic rating;
    final dynamic minimumOrderValue;
    final String id;
    final String name;
    final Branch branch;
    final String type;
    final String openTime;
    final String closeTime;
    final dynamic commission;
    final dynamic dCommission;
    final dynamic sortOrder;
    final String gst;
    final String fssai;
    final User user;
    final List<dynamic> storeBanner;
    final List<CategoryElement> category;
    final String createdAt;
    final String updatedAt;
    final dynamic v;
    final String fcmToken;

    factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        storeLogo: json["storeLogo"] == null ? null : StoreBg.fromJson(json["storeLogo"]),
        storeBg: json["storeBg"] == null ? null : StoreBg.fromJson(json["storeBg"]),
        location: json["location"] == null ? null : VendorLocation.fromJson(json["location"]),
        contactNumber: json["contactNumber"] == null ? null : json["contactNumber"],
        quickDelivery: json["quickDelivery"] == null ? null : json["quickDelivery"],
        storeStatus: json["storeStatus"] == null ? null : json["storeStatus"],
        addons: json["addons"] == null ? null : List<dynamic>.from(json["addons"].map((x) => x)),
        featured: json["featured"] == null ? null : json["featured"],
        rating: json["rating"] == null ? null : json["rating"],
        minimumOrderValue: json["minimumOrderValue"] == null ? null : json["minimumOrderValue"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        type: json["type"] == null ? null : json["type"],
        openTime: json["openTime"] == null ? null : json["openTime"],
        closeTime: json["closeTime"] == null ? null : json["closeTime"],
        commission: json["commission"] == null ? null : json["commission"],
        dCommission: json["dCommission"] == null ? null : json["dCommission"],
        sortOrder: json["sortOrder"] == null ? null : json["sortOrder"],
        gst: json["gst"] == null ? null : json["gst"],
        fssai: json["fssai"] == null ? null : json["fssai"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        storeBanner: json["storeBanner"] == null ? null : List<dynamic>.from(json["storeBanner"].map((x) => x)),
        category: json["category"] == null ? null : List<CategoryElement>.from(json["category"].map((x) => CategoryElement.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
        v: json["__v"] == null ? null : json["__v"],
        fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
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
        "commission": commission == null ? null : commission,
        "dCommission": dCommission == null ? null : dCommission,
        "sortOrder": sortOrder == null ? null : sortOrder,
        "gst": gst == null ? null : gst,
        "fssai": fssai == null ? null : fssai,
        "user": user == null ? null : user.toJson(),
        "storeBanner": storeBanner == null ? null : List<dynamic>.from(storeBanner.map((x) => x)),
        "category": category == null ? null : List<dynamic>.from(category.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
        "__v": v == null ? null : v,
        "fcmToken": fcmToken == null ? null : fcmToken,
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

class CategoryElement {
    CategoryElement({
        @required this.status,
        @required this.id,
        @required this.category,
    });

    final bool status;
    final String id;
    final CategoryCategory category;

    factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
        status: json["status"] == null ? null : json["status"],
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null ? null : CategoryCategory.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "_id": id == null ? null : id,
        "category": category == null ? null : category.toJson(),
    };
}

class CategoryCategory {
    CategoryCategory({
        @required this.image,
        @required this.id,
        @required this.name,
        @required this.type,
    });

    final StoreBg image;
    final String id;
    final String name;
    final String type;

    factory CategoryCategory.fromJson(Map<String, dynamic> json) => CategoryCategory(
        image: json["image"] == null ? null : StoreBg.fromJson(json["image"]),
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "image": image == null ? null : image.toJson(),
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
    };
}

class StoreBg {
    StoreBg({
        @required this.key,
        @required this.image,
    });

    final String key;
    final String image;

    factory StoreBg.fromJson(Map<String, dynamic> json) => StoreBg(
        key: json["key"] == null ? null : json["key"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "image": image == null ? null : image,
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
