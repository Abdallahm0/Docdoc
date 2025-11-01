import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.011),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ColorsManager.blue, width: 1.5),
              ),
              alignment: Alignment.center,
              child: Text(
                "Cancel Appointment",
                style: TextStyle(
                  color: ColorsManager.blue,
                  fontSize: size.width * 0.033,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),

        SizedBox(width: size.width * 0.02),

        Expanded(
          child: InkWell(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.011),
              decoration: BoxDecoration(
                color: ColorsManager.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text(
                "Reschedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.033,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}