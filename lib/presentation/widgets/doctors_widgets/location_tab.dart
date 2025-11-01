import 'package:docdoc/core/utils/app_text_styles.dart';
import 'package:docdoc/data/doctor_model.dart';
import 'package:flutter/material.dart';

class LocationTab extends StatefulWidget {
  final DoctorModel doctor;
  const LocationTab({super.key, required this.doctor});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Address : "
        ,style: AppTextStyles.title),
        SizedBox(height: 8),
        Text(widget.doctor.address),
      ],
    );
  }
}