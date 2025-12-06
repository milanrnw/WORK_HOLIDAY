import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:work_holiday/core/api_requests.dart';
import 'package:work_holiday/models/country/country_main_model.dart';

class CountryProvider extends ChangeNotifier {
  bool _isLoading = false;
  CountryMainModel? _countriesData;

  bool get isLoading => _isLoading;
  CountryMainModel? get countriesData => _countriesData;

  Future<void> fetchCountries() async {
    _isLoading = true;

    try {
      final response = await http.get(Uri.parse(ApiRequests.countriesUrl));

      if (response.statusCode == 200) {
        _countriesData = countryMainModelFromJson(response.body);
      }
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
