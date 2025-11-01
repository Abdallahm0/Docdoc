import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class SpecialtiesWidget extends StatefulWidget {
  const SpecialtiesWidget({super.key});

  @override
  State<SpecialtiesWidget> createState() => _SpecialtiesWidgetState();
}

class _SpecialtiesWidgetState extends State<SpecialtiesWidget> {

  String selectedSpecialty = '';
  final List<String> specialties = [
    "Dentist",
    "Cardiologist",
    "Neurologist",
    "Pediatrician",
    "General",
  ];

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 41,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specialties.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          final isSelected = selectedSpecialty == specialty;

          return ChoiceChip(
            label: Text(specialty),
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: Colors.transparent),
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                selectedSpecialty = isSelected ? '' : specialty;
              });
            },
            selectedColor: ColorsManager.blue,
            backgroundColor: ColorsManager.grey3,
            labelStyle: TextStyle(
              color: isSelected
                  ? ColorsManager.white
                  : ColorsManager.lightGrey,
            ),
          );
        },
      ),
    );
  }
}