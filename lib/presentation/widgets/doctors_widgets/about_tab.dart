import 'package:docdoc/data/doctor_model.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_text_styles.dart';

class AboutTab extends StatefulWidget {
  final DoctorModel doctor;

  const AboutTab({super.key, required this.doctor});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        Text("About me", style: AppTextStyles.title),
        SizedBox(height: 8),
        Text(widget.doctor.description, style: AppTextStyles.about),
        SizedBox(height: 16),
        Text("Working Time", style: AppTextStyles.title),
        SizedBox(height: 8),
        Text("${widget.doctor.startTime} - ${widget.doctor.endTime}",
            style: AppTextStyles.about),
        SizedBox(height: 16),
        Text("Phone", style: AppTextStyles.title),
        const SizedBox(height: 8),
        Text(widget.doctor.phone, style: AppTextStyles.about),
        const SizedBox(height: 16),
        Text("E-Mail", style: AppTextStyles.title),
        const SizedBox(height: 8),

        Text(widget.doctor.email, style: AppTextStyles.about),
        const SizedBox(height: 16),

        Text("Specialization", style: AppTextStyles.title),
        const SizedBox(height: 8),
        Text(widget.doctor.specialization!.name, style: AppTextStyles.about),
        const SizedBox(height: 16),

        Text("City", style: AppTextStyles.title),
        const SizedBox(height: 8),
        Text(
          "${widget.doctor.city!.name}, ${widget.doctor.city!.governrate!.name}",
          style: AppTextStyles.about,
        ),
      ],
    );
  }
}