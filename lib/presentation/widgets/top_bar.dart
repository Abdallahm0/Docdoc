import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String text;
  final Widget? trailing;
  final Color? color;
  final bool showBack;

  const TopBar({
    super.key,
    required this.text,
    this.trailing,
    this.color,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showBack
            ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: color),
        )
            : const SizedBox(width: 45),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: color,
          ),
        ),
        trailing ?? const SizedBox(width: 45),
      ],
    );
  }
}