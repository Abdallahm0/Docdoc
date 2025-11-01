import 'package:docdoc/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class GenderDropdown extends StatefulWidget {
  final TextEditingController controller;

  const GenderDropdown({Key? key, required this.controller}) : super(key: key);

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  final Map<int, String> genders = {
    0: "Male",
    1: "Female",
  };

  int? selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isNotEmpty) {
      selectedValue = int.tryParse(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: const Text(
          'Choose Gender',
          style: TextStyle(fontSize: 16),
        ),
        items: genders.entries
            .map((entry) => DropdownMenuItem<int>(
          value: entry.key,
          child: Text(entry.value, style: TextStyle(
            fontSize: 16,
            color: ColorsManager.lightGrey,
          ),),
        ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.controller.text = value.toString();
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 55,
          decoration: BoxDecoration(
            color: ColorsManager.white2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorsManager.lightGrey),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
        ),
      ),
    );
  }
}