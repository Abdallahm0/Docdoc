import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class FindNearbyWidget extends StatefulWidget {
  const FindNearbyWidget({super.key});

  @override
  State<FindNearbyWidget> createState() => _FindNearbyWidgetState();
}

class _FindNearbyWidgetState extends State<FindNearbyWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: height * 0.19,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: AssetImage("assets/images/Background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: width * 0.04,
          top: height * 0.015,
          child: Text(
            "Book and\nschedule with\nnearest doctor",
            style: TextStyle(
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
              color: ColorsManager.white,
            ),
          ),
        ),
        Positioned(
          top: -height * 0.026,
          left: width * 0.50,
          child: Image.asset("assets/images/doctorPic.png"),
        ),
        Positioned(
          left: width * 0.04,
          top: height * 0.12,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 109,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: ColorsManager.white,
              ),
              child: Center(
                child: Text(
                  "Find Nearby",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
}