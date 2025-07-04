import 'package:flutter/material.dart';
import 'package:work_holiday/core/api_requests.dart';
import 'package:work_holiday/models/country/country_details_model.dart';
import 'package:work_holiday/models/workday/workdays_model.dart';
import 'package:http/http.dart' as http;

class WorkingdaysScreen extends StatefulWidget {
  final CountryDetailsModel country;

  const WorkingdaysScreen({super.key, required this.country});

  @override
  State<WorkingdaysScreen> createState() => _WorkingdaysScreenState();
}

class _WorkingdaysScreenState extends State<WorkingdaysScreen> {
  DateTime startDate = DateTime(2024, 01, 01);
  DateTime endDate = DateTime(2024, 12, 31);

  WorkdaysModel? workdaysDetails;
  bool isLoading = false;

  Future<void> calculateWorkdays() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse(
        "${ApiRequests.workdaysUrl}?country=${widget.country.code}&start=${startDate.toString()}&end=${endDate.toString()}&pretty&key=22ff383e-b26b-4df1-805e-3a0437dd94b7"));

    if (response.statusCode == 200) {
      workdaysDetails = workdaysModelFromJson(response.body);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Oops! Something went wrong.")));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.country.name} Working days"),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Start date : "),
                    InkWell(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024, 1, 1),
                            lastDate: DateTime(2024, 12, 31),
                            initialDate: startDate);
                        setState(() {
                          if (selectedDate != null) {
                            startDate = selectedDate;
                          }
                        });
                      },
                      child: Text(
                        startDate.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("End date : "),
                    InkWell(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2024, 1, 1),
                            lastDate: DateTime(2024, 12, 31),
                            initialDate: endDate);

                        setState(() {
                          if (selectedDate != null) {
                            endDate = selectedDate;
                          }
                        });
                      },
                      child: Text(
                        endDate.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            await calculateWorkdays();
                          },
                          child: Text(
                            "Calculate Workdays",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    if (workdaysDetails != null)
                      Center(
                        child: Text(
                          workdaysDetails!.workdays.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                )),
    );
  }
}
