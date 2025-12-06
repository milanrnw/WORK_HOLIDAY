import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:work_holiday/core/api_requests.dart';
import 'package:work_holiday/models/country/country_details_model.dart';
import 'package:work_holiday/models/holiday/holiday_main_model.dart';
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

    try {
      final response = await http.get(Uri.parse(
        ApiRequests.holidaysUrls(
          countryCode: widget.countryDetails.code,
          year: 2024,
        ),
      ));
      if (response.statusCode == 200) {
        holidayData = holidayMainModelFromJson(response.body);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Oops! Something went wrong.")));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("An error occurred: $e")));
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
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: HolidayCard(
                        index: index,
                        holidayDetails: holidayData.holidays[index]),
                  ),
                ),
    );
  }
}
