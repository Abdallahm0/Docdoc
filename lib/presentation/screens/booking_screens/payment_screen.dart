import 'package:docdoc/core/utils/app_text_styles.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/screens/booking_screens/summary_screen.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/booking_steps_indicator.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/payment_widget.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import '../../../data/doctor_model.dart';

class PaymentScreen extends StatefulWidget {
  final DateTime date;
  final String time;
  final String appointmentType;
  final DoctorModel doctor;

  const PaymentScreen({super.key,
    required this.date,
    required this.time,
    required this.appointmentType,
    required this.doctor
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMainMethod = 'Credit Card';
  String? selectedCardOption;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
              BookingStepsIndicator(currentStep: 1),
              SizedBox(height: size.height * 0.02),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Text("Payment Option", style: AppTextStyles.title),

                      PaymentWidget(
                        onSelectionChanged: (method, option) {
                          setState(() {
                            selectedMainMethod = method;
                            selectedCardOption = option;
                          });
                        },
                      ),

                      SizedBox(height: size.height * 0.19),
                    ],
                  ),
                ),
              ),

              ButtonWidget(
                text: "Continue",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SummaryScreen(
                        date: widget.date,
                        time: widget.time,
                        appointmentType: widget.appointmentType,
                        paymentMethod: selectedMainMethod,
                        cardType: selectedCardOption,
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