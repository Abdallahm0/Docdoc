import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/reviews_tab.dart';
import 'package:docdoc/presentation/screens/booking_screens/choose_time_screen.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/about_tab.dart';
// import 'package:docdoc/presentation/widgets/button_widget.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/doctor_header_info.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/location_tab.dart';
// import 'package:docdoc/presentation/widgets/doctors_widgets/reviews_tab.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/tab_bar_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import '../../../data/doctor_model.dart';

class AboutScreen extends StatefulWidget {
  final DoctorModel doctor;

  const AboutScreen({super.key, required this.doctor});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final doctor = widget.doctor;

    final horizontalPadding = size.width * 0.06;
    final verticalPadding = size.height * 0.03;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopBar(text: widget.doctor.name),
                SizedBox(height: size.height * 0.03),
                DoctorHeaderInfo(doctor: doctor, showMessageIcon: true,),
                SizedBox(height: size.height * 0.03),

                TabBarWidget(),

                SizedBox(height: size.height * 0.02),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: TabBarView(
                      children: [
                        AboutTab(doctor: doctor,),
                        LocationTab(doctor: doctor,),
                        ReviewsTab(),
                      ],
                    ),
                  ),
                ),
                ButtonWidget(text: "Make An Appointment", onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> ChooseTimeScreen(doctor: doctor)));
                },),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
