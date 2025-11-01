import 'package:docdoc/core/utils/app_text_styles.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/rec_doctors_widget.dart';
import 'package:docdoc/presentation/widgets/home_widgets/specialties_widget.dart';
import 'package:docdoc/presentation/widgets/search_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = '';
  int currentIndex = 0;

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.05,
          size.height * 0.07,
          size.width * 0.05,
          size.height * 0.001,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(text: "Search"),
            SizedBox(height: size.height * 0.02),

            SearchWidget(
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),

            SizedBox(height: size.height * 0.02),
            SpecialtiesWidget(),
            SizedBox(height: size.height * 0.03),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Results", style: AppTextStyles.title),
                    RecDoctorsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}