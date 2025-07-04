class HolidayDetailsModel {
  final String name;
  final DateTime date;

  HolidayDetailsModel({
    required this.name,
    required this.date,
  });

  factory HolidayDetailsModel.fromJson(Map<String, dynamic> json) => HolidayDetailsModel(
        name: json["name"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
