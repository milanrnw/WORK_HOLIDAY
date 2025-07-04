// To parse this JSON data, do
//
//     final holidayMainModel = holidayMainModelFromJson(jsonString);

import 'dart:convert';

import 'package:work_holiday/models/holiday/holiday_details_model.dart';

HolidayMainModel holidayMainModelFromJson(String str) =>
    HolidayMainModel.fromJson(json.decode(str));

String holidayMainModelToJson(HolidayMainModel data) =>
    json.encode(data.toJson());

class HolidayMainModel {
  final List<HolidayDetailsModel> holidays;

  HolidayMainModel({
    required this.holidays,
  });

  factory HolidayMainModel.fromJson(Map<String, dynamic> json) =>
      HolidayMainModel(
        holidays: List<HolidayDetailsModel>.from(
            json["holidays"].map((x) => HolidayDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "holidays": List<dynamic>.from(holidays.map((x) => x.toJson())),
      };
}
