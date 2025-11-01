import 'package:docdoc/presentation/screens/my_appointment_screens/my_appointment_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class MyAppointWidget extends StatefulWidget {
  const MyAppointWidget({super.key});

  @override
  State<MyAppointWidget> createState() => _MyAppointWidgetState();
}

class _MyAppointWidgetState extends State<MyAppointWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 59,
      decoration: BoxDecoration(
        color: ColorsManager.white2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> MyAppointmentScreen()));
            },
            child: Text("My Appointment",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorsManager.black,
              ),),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 30),
          ),
          InkWell(
            onTap: (){},
            child: Text("Medical records",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorsManager.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}