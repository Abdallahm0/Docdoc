import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/data/doctor_model.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/rec_doctors_widget.dart';
import 'package:docdoc/presentation/widgets/search_widget.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class DoctorsBySpecializationScreen extends StatefulWidget {
  final String specializationName;
  final List<DoctorModel> doctors;

  const DoctorsBySpecializationScreen({
    Key? key,
    required this.specializationName,
    required this.doctors,
  }) : super(key: key);

  @override
  State<DoctorsBySpecializationScreen> createState() =>
      _DoctorsBySpecializationScreenState();
}

class _DoctorsBySpecializationScreenState
    extends State<DoctorsBySpecializationScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            size.width * 0.04,
            size.height * 0.03,
            size.width * 0.04,
            size.height * 0.04,
          ),
          child: Column(
            children: [
              TopBar(
                text: widget.specializationName,
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_outlined),
                ),
              ),

              SizedBox(height: size.height * 0.02),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SearchWidget(),
                      SizedBox(height: size.height * 0.02),

                      widget.doctors.isNotEmpty
                          ? RecDoctorsWidget(doctors: widget.doctors)
                          : Center(
                        child: Text(
                          "لا يوجد دكاترة متاحة",
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorsManager.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}