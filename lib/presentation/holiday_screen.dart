import 'package:flutter/material.dart';
import 'package:work_holiday/core/api_requests.dart';
import 'package:work_holiday/models/country/country_details_model.dart';
import 'package:work_holiday/models/holiday/holiday_main_model.dart';
import 'package:http/http.dart' as http;
import 'package:work_holiday/widgets/holiday_card.dart';

class HolidayScreen extends StatefulWidget {
  final CountryDetailsModel countryDetails;

  const HolidayScreen({super.key, required this.countryDetails});

  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  bool isLoading = false;
  late HolidayMainModel holidayData;

  Future<void> fetchHolidays() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse("${ApiRequests.holidaysUrl}?country=${widget.countryDetails.code}&year=2024&pretty&key=22ff383e-b26b-4df1-805e-3a0437dd94b7"));

    if (response.statusCode == 200) {
      holidayData = holidayMainModelFromJson(response.body);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops! Something went wrong.")));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.countryDetails.name} Holidays"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (holidayData.holidays.isEmpty)
              ? Text("No holidays found")
              : ListView.builder(
                itemCount: holidayData.holidays.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 10,right: 10),
                    child: HolidayCard(
                        index: index,
                        holidayDetails: holidayData.holidays[index]),
                  ),
                ),
    );
  }
}
