import 'package:docdoc/core/utils/app_text_styles.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/screens/booking_screens/payment_screen.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/appointment_type_widget.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/booking_steps_indicator.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/select_date_widget.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/doctor_model.dart';
import '../../widgets/booking_widgets/available_time_widget.dart';
import 'package:intl/intl.dart';

class ChooseTimeScreen extends StatefulWidget {
  final DoctorModel doctor;
  const ChooseTimeScreen({super.key, required this.doctor});

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  String selectedTime = '';
  DateTime selectedDate = DateTime.now();
  String selectedAppointmentType = "In Person";

  int to24Hour(int hour, String period) {
    if (period == "PM" && hour != 12) return hour + 12;
    if (period == "AM" && hour == 12) return 0;
    return hour;
  }

  List<String> generateAvailableTimes(String startTime, String endTime, {int intervalMinutes = 30}) {
    final startParts = startTime.split(RegExp(r'[: ]'));
    final endParts = endTime.split(RegExp(r'[: ]'));

    int startHour = int.parse(startParts[0]);
    int startMinute = int.parse(startParts[1]);
    String startPeriod = startParts[2];

    int endHour = int.parse(endParts[0]);
    int endMinute = int.parse(endParts[1]);
    String endPeriod = endParts[2];

    final now = DateTime.now();
    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      to24Hour(startHour, startPeriod),
      startMinute,
    );
    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      to24Hour(endHour, endPeriod),
      endMinute,
    );

    List<String> times = [];
    DateTime current = startDateTime;

    while (current.isBefore(endDateTime) || current.isAtSameMomentAs(endDateTime)) {
      times.add(DateFormat("HH:mm").format(current));
      current = current.add(Duration(minutes: intervalMinutes));
    }

    return times;
  }

  DateTime combineDateTime24(DateTime date, String time24) {
    final parts = time24.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final availableTimes = generateAvailableTimes(widget.doctor.startTime, widget.doctor.endTime);

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
              TopBar(text: "Book Appointment"),
              SizedBox(height: size.height * 0.02),
              BookingStepsIndicator(currentStep: 0),
              SizedBox(height: size.height * 0.02),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Date", style: AppTextStyles.title),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "Set Manual",
                              style: TextStyle(
                                color: ColorsManager.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      SelectDateWidget(
                        selectDate: selectedDate,
                        onDateSelected: (newDate) {
                          setState(() {
                            selectedDate = newDate;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text("Available Time", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.02),

                      AvailableTimeWidget(
                        times: availableTimes,
                        selectedTime: selectedTime,
                        onTimeSelected: (time) {
                          setState(() {
                            selectedTime = time;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                      Text("Appointment Type", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.02),
                      AppointmentTypeWidget(
                        selectedType: selectedAppointmentType,
                        onTypeSelected: (value) {
                          setState(() {
                            selectedAppointmentType = value;
                          });
                        },
                      ),
                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ),
              ButtonWidget(
                text: "Continue",
                onTap: () {
                  if (selectedTime.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a time")),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        date: selectedDate,
                        time: selectedTime,
                        appointmentType: selectedAppointmentType,
                        doctor: widget.doctor,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}