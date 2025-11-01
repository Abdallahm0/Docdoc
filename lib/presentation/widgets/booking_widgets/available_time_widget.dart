import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AvailableTimeWidget extends StatelessWidget {
  final List<String> times;
  final String selectedTime;
  final Function(String) onTimeSelected;

  const AvailableTimeWidget({
    super.key,
    required this.times,
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      padding: EdgeInsets.only(top: size.height * 0.002),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: size.width * 0.05,
        mainAxisSpacing: size.height * 0.02,
        childAspectRatio: 3.2,
      ),
      itemBuilder: (context, index) {
        final time = times[index];
        final isSelected = time == selectedTime;

        return GestureDetector(
          onTap: () => onTimeSelected(time),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.blue : ColorsManager.white2,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? ColorsManager.white : ColorsManager.lightGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}