import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRequests {
  ApiRequests._();

  static final String baseUrl =
      dotenv.env['BASE_URL'] ?? 'https://holidayapi.com/v1/';
  static final String apiKey = dotenv.env['API_KEY'] ?? '';

  static String get countriesUrl => '${baseUrl}countries?pretty&key=$apiKey';
  static String get holidaysUrl => '${baseUrl}holidays?pretty&key=$apiKey';
  static String get workdaysUrl => '${baseUrl}workdays?pretty&key=$apiKey';

  static String holidaysUrls({
    required String countryCode,
    required int year,
  }) {
    return '${baseUrl}holidays?country=$countryCode&year=$year&pretty&key=$apiKey';
  }

  static String workdaysUrlWithParams({
    required String countryCode,
    required String startDate,
    required String endDate,
  }) {
    return '${baseUrl}workdays?country=$countryCode&start=$startDate&end=$endDate&pretty&key=$apiKey';
  }
}
