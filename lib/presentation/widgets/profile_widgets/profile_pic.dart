import 'package:flutter/material.dart';
import '../../../core/utils/colors.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Positioned(
      left: width / 2 - 58,
      top: -50,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 123,
            height: 123,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.white,
            ),
            child: Image.asset(
              "assets/images/pic.png",
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            right: -4,
            bottom: -4,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.white,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  color: ColorsManager.blue,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}