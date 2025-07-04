import 'package:flutter/material.dart';
import 'package:work_holiday/models/holiday/holiday_details_model.dart';

class HolidayCard extends StatelessWidget {
  const HolidayCard({
    super.key,
    required this.index,
    required this.holidayDetails,
  });

  final HolidayDetailsModel holidayDetails;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: (index % 2 == 0) ? Colors.blueAccent : Colors.amberAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            holidayDetails.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            holidayDetails.date.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
