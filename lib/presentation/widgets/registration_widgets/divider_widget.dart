import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: Divider(
            thickness: 1,
            color: ColorsManager.lightGrey,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Or sign in with",
            style: TextStyle(
              color: ColorsManager.lightGrey,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
         Expanded(
          child: Divider(
            thickness: 1,
            color: ColorsManager.lightGrey,
          ),
        ),
      ],
    );
  }
}