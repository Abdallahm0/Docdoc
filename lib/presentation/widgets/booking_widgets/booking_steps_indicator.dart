import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';

class BookingStepsIndicator extends StatelessWidget {
  final int currentStep;

  const BookingStepsIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final List<String> _steps = const ['Date & Time', 'Payment', 'Summary'];

    return Row(
      children: List.generate(_steps.length * 2 - 1, (index) {
        if (index.isEven) {
          int stepIndex = index ~/ 2;
          bool isCompleted = stepIndex < currentStep;
          bool isCurrent = stepIndex == currentStep;

          final size = MediaQuery.of(context).size;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              children: [
                Container(
                  padding:  EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? ColorsManager.blue
                        : isCompleted
                        ? ColorsManager.green
                        : ColorsManager.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${stepIndex + 1}',
                    style:  TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                 SizedBox(height: 6),
                Text(
                  _steps[stepIndex],
                  style: TextStyle(
                    color: isCurrent
                        ? ColorsManager.blue
                        : isCompleted
                        ? ColorsManager.green
                        : ColorsManager.grey,
                    fontSize: 10,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Expanded(
            child: Divider(
              color: index ~/ 2 < currentStep
                  ? ColorsManager.green
                  : ColorsManager.grey,
              thickness: 2,
            ),
          );
        }
      }),
    );
  }
}