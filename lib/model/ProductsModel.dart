// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    ProductsModel({
        @required this.success,
        @required this.products,
    });

    final bool success;
    final List<ProductsModelProduct> products;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        success: json["success"] == null ? null : json["success"],
        products: json["products"] == null ? null : List<ProductsModelProduct>.from(json["products"].map((x) => ProductsModelProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class ProductsModelProduct {
    ProductsModelProduct({
        @required this.id,
        @required this.category,
    });

    final String id;
    final Category category;

    factory ProductsModelProduct.fromJson(Map<String, dynamic> json) => ProductsModelProduct(
        id: json["_id"] == null ? null : json["_id"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "category": category == null ? null : category.toJson(),
    };
}

class Category {
    Category({
        @required this.id,
        @required this.status,
        @required this.name,
        @required this.type,
        @required this.vendorCategory,
        @required this.vendorCategoryStatus,
        @required this.products,
    });

    final String id;
    final bool status;
    final String name;
    final String type;
    final String vendorCategory;
    final bool vendorCategoryStatus;
    final List<CategoryProduct> products;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        vendorCategory: json["vendorCategory"] == null ? null : json["vendorCategory"],
        vendorCategoryStatus: json["vendorCategoryStatus"] == null ? null : json["vendorCategoryStatus"],
        products: json["products"] == null ? null : List<CategoryProduct>.from(json["products"].map((x) => CategoryProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "vendorCategory": vendorCategory == null ? null : vendorCategory,
        "vendorCategoryStatus": vendorCategoryStatus == null ? null : vendorCategoryStatus,
        "products": products == null ? null : List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class CategoryProduct {
    CategoryProduct({
        @required this.id,
        @required this.status,
        @required this.type,
        @required this.name,
    });

    final String id;
    final bool status;
    final String type;
    final String name;

    factory CategoryProduct.fromJson(Map<String, dynamic> json) => CategoryProduct(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
    };
}
