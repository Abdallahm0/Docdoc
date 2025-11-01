import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateWidget extends StatelessWidget {
  final DateTime selectDate;
  final Function(DateTime) onDateSelected;

  const SelectDateWidget({
    super.key,
    required this.selectDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dates = List.generate(7, (index) => now.add(Duration(days: index)));

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: dates.length,
              itemBuilder: (context, index) {
                final date = dates[index];
                final isSelected =
                    date.day == selectDate.day &&
                        date.month == selectDate.month &&
                        date.year == selectDate.year;
                return GestureDetector(
                  onTap: () => onDateSelected(date),
                  child: Container(
                    width: 55,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? ColorsManager.blue : ColorsManager.white2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? ColorsManager.white
                                : ColorsManager.lightGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected
                                ? ColorsManager.white
                                : ColorsManager.lightGrey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Left Arrow
        Positioned(
          left: 0,
          top: 20,
          bottom: 20,
          child: SizedBox(
            width: 30,
            child: Icon(Icons.arrow_back_ios, size: 16, color: ColorsManager.grey),
          ),
        ),
        // Right Arrow
        Positioned(
          right: 0,
          top: 20,
          bottom: 20,
          child: SizedBox(
            width: 30,
            child: Icon(Icons.arrow_forward_ios, size: 16, color: ColorsManager.grey),
          ),
        ),
      ],
    );
  }
}