import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInOptionsWidget extends StatelessWidget {
  const SignInOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.12; // responsive size
    final iconSize = containerSize * 0.7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLogo("assets/logos/facebookLogo.svg", containerSize, iconSize),
        _buildLogo("assets/logos/googleLogo.svg", containerSize, iconSize),
        _buildLogo("assets/logos/appleLogo.svg", containerSize, iconSize),
      ],
    );
  }

  Widget _buildLogo(String imagePath, double containerSize, double iconSize) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){},
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorsManager.white2,
        ),
        child: Center(
          child: SvgPicture.asset(
            imagePath,
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}