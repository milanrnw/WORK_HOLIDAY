// To parse this JSON data, do
//
//     final workdaysModel = workdaysModelFromJson(jsonString);

import 'dart:convert';

WorkdaysModel workdaysModelFromJson(String str) => WorkdaysModel.fromJson(json.decode(str));

String workdaysModelToJson(WorkdaysModel data) => json.encode(data.toJson());

class WorkdaysModel {
    final int workdays;

    WorkdaysModel({
        required this.workdays,
    });

    factory WorkdaysModel.fromJson(Map<String, dynamic> json) => WorkdaysModel(
        workdays: json["workdays"],
    );

    Map<String, dynamic> toJson() => {
        "workdays": workdays,
    };
}