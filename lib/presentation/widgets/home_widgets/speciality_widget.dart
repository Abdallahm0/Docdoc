import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../../data/doctor_model.dart';
import '../../screens/home_screens/doctors_by_specialization_screen.dart';

class SpecialityWidget extends StatefulWidget {
  final List<SpecializationWithDoctors> specializations;

  const SpecialityWidget({super.key, required this.specializations});

  @override
  State<SpecialityWidget> createState() => _SpecialityWidgetState();
}

class _SpecialityWidgetState extends State<SpecialityWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.16;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: widget.specializations.map((spec) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: _buildSpec(context, spec, containerSize),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpec(
      BuildContext context, SpecializationWithDoctors spec, double containerSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DoctorsBySpecializationScreen(
                  specializationName: spec.name,
                  doctors: spec.doctors,
                ),
              ),
            );
          },
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.light,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                "assets/logos/${spec.name}.png",
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.medical_services),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: containerSize + 10,
          child: Text(
            spec.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}