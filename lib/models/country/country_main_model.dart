// To parse this JSON data, do
//
//     final countryMainModel = countryMainModelFromJson(jsonString);

import 'dart:convert';

import 'package:work_holiday/models/country/country_details_model.dart';

CountryMainModel countryMainModelFromJson(String str) => CountryMainModel.fromJson(json.decode(str));

String countryMainModelToJson(CountryMainModel data) => json.encode(data.toJson());

class CountryMainModel {
    final List<CountryDetailsModel> countries;

    CountryMainModel({
        required this.countries,
    });

    factory CountryMainModel.fromJson(Map<String, dynamic> json) => CountryMainModel(
        countries: List<CountryDetailsModel>.from(json["countries"].map((x) => CountryDetailsModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    };
}
