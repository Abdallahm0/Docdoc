import 'package:docdoc/logic/user/post/cubit.dart';
import 'package:docdoc/presentation/screens/profile_screens/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileOptionsList extends StatelessWidget {
  const ProfileOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildOption(
          context,
          "assets/icons/personalcard.svg",
          "Personal Information",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BlocProvider(
                      create: (context) => UserPostCubit(),
                      child: PersonalInfo(),
                    ),
              ),
            );
          },
        ),
        _buildOption(
          context,
          "assets/icons/directbox.svg",
          "My Test & Diagnostic",
          onTap: () {},
        ),
        _buildOption(
          context,
          "assets/icons/wallet_2 .svg",
          "Payment",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String imagePath, String title,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              imagePath,
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}