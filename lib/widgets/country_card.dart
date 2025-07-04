import 'package:flutter/material.dart';
import 'package:work_holiday/models/country/country_details_model.dart';
import 'package:work_holiday/presentation/holiday_screen.dart';
import 'package:work_holiday/presentation/workingdays_screen.dart';

class CountryCard extends StatelessWidget {
  final int index;
  final CountryDetailsModel country;

  const CountryCard({super.key, required this.index, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (index % 2 == 0) ? Colors.blueAccent : Colors.amberAccent,
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20).copyWith(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                country.flag,
                height: 32,
                width: 32,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/default_image.png",
                  height: 32,
                  width: 32,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                country.code,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "Country: ${country.name}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Row(
            children: [
              (country.currencies.isEmpty)
                  ? const SizedBox()
                  : Text(
                      "Currenty: ${country.currencies.first.alpha}",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HolidayScreen(countryDetails: country,)));
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.greenAccent)),
                child: const Text(
                  "Get Holidays",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WorkingdaysScreen(country: country,)));
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.orangeAccent)),
                child: const Text(
                  "Get Workdays",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
