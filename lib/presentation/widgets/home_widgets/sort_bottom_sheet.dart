import 'package:docdoc/presentation/widgets/home_widgets/specialties_widget.dart';
import 'package:flutter/material.dart';
import 'package:docdoc/core/utils/colors.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  String selectedSpecialty = '';
  String selectedRating = '';

  final List<String> specialties = [
    "Dentist",
    "Cardiologist",
    "Neurologist",
    "Pediatrician",
    "General",
  ];

  final List<String> ratings = ["5.0", "4.5", "4.0", "3.5", "3.0"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.6,
      minChildSize: 0.3,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Center(
                child: Text("Sore By", style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.black)),
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(child: Divider(
                thickness: 1,
                color: ColorsManager.grey3,
              )),
              SizedBox(height: size.height * 0.03),

              Text(
                "Specialty",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: size.height * 0.04),
              SpecialtiesWidget(),
              SizedBox(height: size.height * 0.05),

              const Text(
                "Rating",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: size.height * 0.04),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ratings.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final rating = ratings[index];
                    final isSelected = selectedRating == rating;

                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: isSelected
                                ? ColorsManager.white
                                : ColorsManager.lightGrey,
                          ),
                          SizedBox(width: 4),
                          Text(rating),
                        ],
                      ),
                      showCheckmark: false,
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          selectedRating = isSelected ? '' : rating;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.transparent),
                      ),
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
              ),

              SizedBox(height: size.height * 0.100),

              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: ColorsManager.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: ColorsManager.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}