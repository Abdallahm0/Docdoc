import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class HaveAccWidget extends StatelessWidget {
  const HaveAccWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account yet?",
          style: TextStyle(
            fontSize: size.width * 0.028,
            fontWeight: FontWeight.w400,
            color: ColorsManager.black,
          ),
        ),
        SizedBox(width: size.width * 0.01),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: size.width * 0.028,
              fontWeight: FontWeight.w500,
              color: ColorsManager.blue,
            ),
          ),
        ),
      ],
    );
  }
}