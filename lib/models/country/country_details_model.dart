import 'package:work_holiday/models/country/currency_model.dart';

class CountryDetailsModel {
    final String code;
    final String name;
    final List<CurrencyModel> currencies;
    final String flag;

    CountryDetailsModel({
        required this.code,
        required this.name,
        required this.currencies,
        required this.flag,
    });

    factory CountryDetailsModel.fromJson(Map<String, dynamic> json) => CountryDetailsModel(
        code: json["code"],
        name: json["name"],
        currencies: List<CurrencyModel>.from(json["currencies"].map((x) => CurrencyModel.fromJson(x))),
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
        "flag": flag,
    };
}