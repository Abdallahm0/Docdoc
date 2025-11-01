import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class TextSpanWidget extends StatelessWidget {
  const TextSpanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: ColorsManager.lightGrey, fontSize: 11),
          children: [
            TextSpan(text: "By logging, you agree to our"),
            TextSpan(
              text: " Terms & Conditions",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorsManager.black,
              ),
            ),
            TextSpan(text: " and "),
            TextSpan(
              text: "\nPrivacyPolicy.",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}