import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/app_text_styles.dart';

class BookingInformationWidget extends StatelessWidget {
  final String date;
  final String time;
  final String appointmentType;
  final bool showLocationButton;

  const BookingInformationWidget({
    super.key,
    required this.date,
    required this.time,
    required this.appointmentType,
    this.showLocationButton = false
  });

  Widget _buildInfoRow({
    required String iconPath,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 30, width: 30),
          SizedBox(width:19),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.title.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = date;
    try {
      DateTime parsedDate = DateFormat('MMM d, yyyy').parse(date);
      formattedDate = DateFormat('EEEE, d MMMM yyyy').format(parsedDate);
    } catch (_) {}

    return Container(
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(
            iconPath: 'assets/icons/calendar_ic.svg',
            label: 'Date & Time',
            value: '$formattedDate\n$time',
          ),
          Divider(color: ColorsManager.grey.withOpacity(0.1)),
          SizedBox(height: 16,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/appoint_ic.svg', height: 30, width: 30),
              const SizedBox(width: 19),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appointment Type', style: AppTextStyles.title.copyWith(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      appointmentType,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (showLocationButton)
                InkWell(
                  onTap: (){},
                  child: Container(
                    padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: ColorsManager.blue,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: Text(
                      'Get Location',
                      style: TextStyle(
                        color: ColorsManager.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),

        ],
      ),
    );
  }
}