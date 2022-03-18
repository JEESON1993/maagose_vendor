// To parse this JSON data, do
//
//     final analysisModel = analysisModelFromJson(jsonString);

import 'dart:convert';

AnalysisModel analysisModelFromJson(String str) =>
    AnalysisModel.fromJson(json.decode(str));

String analysisModelToJson(AnalysisModel data) => json.encode(data.toJson());

class AnalysisModel {
  AnalysisModel({
    this.order,
    this.total,
  });

  dynamic order;
  dynamic total;

  factory AnalysisModel.fromJson(Map<String, dynamic> json) => AnalysisModel(
        order: json["order"] == null ? null : json["order"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order,
        "total": total == null ? null : total,
      };
}
