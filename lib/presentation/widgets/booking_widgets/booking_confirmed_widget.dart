import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/colors.dart';

class BookingConfirmedWidget extends StatefulWidget {
  const BookingConfirmedWidget({super.key});

  @override
  State<BookingConfirmedWidget> createState() => _BookingConfirmedWidgetState();
}

class _BookingConfirmedWidgetState extends State<BookingConfirmedWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.04),

           Center(
            child: SvgPicture.asset(
              'assets/icons/confirmed.svg',
              height: 78,
              width: 78,
            ),
          ),


        SizedBox(height: 24),

        Text(
          "Booking Confirmed",
          style: AppTextStyles.title.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: ColorsManager.black,
          ),
        ),

      ],
    );
  }
}