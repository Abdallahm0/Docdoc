import 'package:docdoc/presentation/widgets/booking_widgets/booking_confirmed_widget.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/booking_information_widget.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/doctor_header_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/colors.dart';
import '../../../data/doctor_model.dart';
// import '../../widgets/booking_widgets/booking_steps_indicator.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/top_bar.dart';

class ConfirmedScreen extends StatefulWidget {
  final DateTime date;
  final String time;
  final String appointmentType;
  final DoctorModel doctor;

  const ConfirmedScreen({
    super.key,
    required this.date,
    required this.time,
    required this.appointmentType,
    required this.doctor,
  });

  @override
  State<ConfirmedScreen> createState() => _ConfirmedScreenState();
}

class _ConfirmedScreenState extends State<ConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final formattedDate = DateFormat("EEEE, MMMM d, y h:mm a", "en_US").format(widget.date);

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.05,
            size.height * 0.03,
            size.width * 0.05,
            size.height * 0.001,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(text: "Details"),
              SizedBox(height: size.height * 0.04),
              BookingConfirmedWidget(),
              SizedBox(height: size.height * 0.07),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Booking Information", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.007),
                      BookingInformationWidget(
                        date: formattedDate,
                        time: widget.time,
                        appointmentType: widget.appointmentType,
                        showLocationButton: true,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text("Doctor Information", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.03),
                      DoctorHeaderInfo(doctor: widget.doctor),
                      SizedBox(height: size.height * 0.19),
                    ],
                  ),
                ),
              ),

              ButtonWidget(
                text: "Done",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

}