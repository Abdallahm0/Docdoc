import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double picSize = size.width * 0.3;

    return Center(
      child: Container(
        width: picSize,
        height: picSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsManager.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(
          "assets/images/profile.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}