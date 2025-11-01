import 'package:docdoc/presentation/screens/booking_screens/confirmed_screen.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/booking_information_widget.dart';
import 'package:docdoc/presentation/widgets/booking_widgets/payment_information_widget.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/doctor_header_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/colors.dart';
import '../../../data/appointment_model.dart';
import '../../../data/doctor_model.dart';
import '../../../data/user_model.dart';
import '../../../logic/appointment/post/cubit.dart';
import '../../../logic/appointment/post/state.dart';
import '../../widgets/booking_widgets/booking_steps_indicator.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/top_bar.dart';

class SummaryScreen extends StatefulWidget {
  final DateTime date;
  final String time;
  final String appointmentType;
  final String paymentMethod;
  final String? cardType;
  final DoctorModel doctor;

  const SummaryScreen({
    super.key,
    required this.date,
    required this.time,
    required this.appointmentType,
    required this.paymentMethod,
    this.cardType,
    required this.doctor,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

  DateTime combineDateTime24(DateTime date, String time24) {
    final parts = time24.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  Future<UserModel> _getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

    return UserModel(
      id: prefs.getInt('user_id') ?? 0,
      name: prefs.getString('user_name') ?? '',
      email: prefs.getString('user_email') ?? '',
      phone: prefs.getString('user_phone') ?? '',
      gender: prefs.getString('user_gender') ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final selectedDateTime = combineDateTime24(widget.date, widget.time);
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
              TopBar(text: "Book Appointment"),
              SizedBox(height: size.height * 0.02),
              BookingStepsIndicator(currentStep: 2),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Text("Booking Information", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.007),
                      BookingInformationWidget(
                        date: formattedDate,
                        time: widget.time,
                        appointmentType: widget.appointmentType,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text("Doctor Information", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.03),
                      DoctorHeaderInfo(doctor: widget.doctor),
                      SizedBox(height: size.height * 0.02),
                      Text("Payment Information", style: AppTextStyles.title),
                      SizedBox(height: size.height * 0.007),
                      PaymentInformationWidget(
                        method: widget.cardType ?? widget.paymentMethod,
                        info: widget.cardType,
                        total: widget.doctor.appointPrice.toStringAsFixed(2),
                        iconPath: _getPaymentIconPath(
                          widget.paymentMethod,
                          widget.cardType,
                        ),
                      ),
                      SizedBox(height: size.height * 0.19),
                    ],
                  ),
                ),
              ),

              BlocProvider(
                create: (_) => AppointmentPostCubit(),
                child: BlocConsumer<AppointmentPostCubit, AppointmentPostState>(
                  listener: (context, state) {
                    if (state is AppointmentPostSuccessState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmedScreen(
                            date: widget.date,
                            time: widget.time,
                            appointmentType: widget.appointmentType,
                            doctor: widget.doctor,
                          ),
                        ),
                      );
                    } else if (state is AppointmentPostErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AppointmentPostLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ButtonWidget(
                      text: "Book Now",
                      onTap: () async {
                        final user = await _getCurrentUser();

                        final appointment = AppointmentModel(
                          id: 0,
                          doctor: widget.doctor,
                          patient: user,
                          appointmentTime: selectedDateTime,
                          appointmentEndTime: selectedDateTime.add(const Duration(minutes: 30)),
                          status: AppointmentStatus.pending,
                          notes: "eslam",
                          appointmentPrice: widget.doctor.appointPrice,
                        );

                        context.read<AppointmentPostCubit>().createAppointment(
                          appointment: appointment,
                        );


                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPaymentIconPath(String method, String? option) {
    if (method == 'Credit Card') {
      switch (option) {
        case 'Master Card':
          return 'assets/icons/mastercard.svg';
        case 'American Express':
          return 'assets/icons/ae.svg';
        case 'Capital One':
          return 'assets/icons/capone.svg';
        case 'Barclays':
          return 'assets/icons/bar.svg';
        default:
          return 'assets/icons/card.svg';
      }
    } else if (method == 'PayPal') {
      return 'assets/icons/paypal.svg';
    } else if (method == 'Bank Transfer') {
      return 'assets/icons/bank.svg';
    } else {
      return 'assets/icons/card.svg';
    }
  }
}