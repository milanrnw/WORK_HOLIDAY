class ApiRequests {
  ApiRequests._();

  static const baseUrl = "https://holidayapi.com/v1/";
  static const apiKey = "22ff383e-b26b-4df1-805e-3a0437dd94b7";

  static const countriesUrl = "${baseUrl}countries?pretty&key=$apiKey";
  static const holidaysUrl = "${baseUrl}holidays";
  static const workdaysUrl = "${baseUrl}workdays";
}
