import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/colors.dart';

class AppointmentTypeWidget extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const AppointmentTypeWidget({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final types = [
      {
        "label": "In Person",
        "icon": "assets/icons/personal.svg",
      },
      {
        "label": "Video Call",
        "icon": "assets/icons/video.svg",
      },
      {
        "label": "Phone Call",
        "icon": "assets/icons/call.svg",
      },
    ];

    return Column(
      children: List.generate(types.length, (index) {
        final type = types[index];
        final isSelected = selectedType == type['label'];

        return Column(
          children: [
            GestureDetector(
              onTap: () => onTypeSelected(type['label']!),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      type['icon']!,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        type['label']!,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorsManager.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? ColorsManager.blue : ColorsManager.grey,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsManager.blue,
                          ),
                        ),
                      )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            if (index < types.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: ColorsManager.lightGrey.withOpacity(0.4),
                  thickness: 1,
                  height: 0,
                ),
              ),
          ],
        );
      }),
    );
  }
}