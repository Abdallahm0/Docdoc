import 'package:docdoc/data/user_model.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class InfoWidget extends StatelessWidget {
  final UserModel user;
  const InfoWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          user.name,
          style: TextStyle(
            color: ColorsManager.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.lightGrey,
          ),
        ),
        Text(
          user.phone,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.lightGrey,
          ),
        ),
        Text(
          user.gender,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.lightGrey,
          ),
        ),
      ],
    );
  }
}