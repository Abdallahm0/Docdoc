import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../core/utils/colors.dart';

class PhoneNumFieldWidget extends StatefulWidget {
  const PhoneNumFieldWidget({super.key});

  @override
  State<PhoneNumFieldWidget> createState() => _PhoneNumFieldWidgetState();
}

class _PhoneNumFieldWidgetState extends State<PhoneNumFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(
              color: ColorsManager.lightGrey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(
              color: ColorsManager.lightGrey,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide(
              color: ColorsManager.lightGrey,
            ),
          ),
        hintText: 'Your number',
        hintStyle: TextStyle(
          color: ColorsManager.lightGrey,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        filled: true,
        fillColor: ColorsManager.white2,
      ),
      initialCountryCode: 'GB',
      disableLengthCheck: true,

      onChanged: (phone){
        setState(() {
        });
      },
    );
  }
}