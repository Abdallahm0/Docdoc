import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/logic/doc_home/cubit.dart';
import 'package:docdoc/logic/speciality/cubit.dart';
import 'package:docdoc/logic/speciality/state.dart';
import 'package:docdoc/logic/user/get/cubit.dart';
import 'package:docdoc/presentation/screens/home_screens/rec_doctor_screen.dart';
import 'package:docdoc/presentation/screens/home_screens/specializations_screen.dart';
import 'package:docdoc/presentation/widgets/home_widgets/find_nearby_widget.dart';
import 'package:docdoc/presentation/widgets/home_widgets/home_top_widget.dart';
import 'package:docdoc/presentation/widgets/doctors_widgets/rec_doctors_widget.dart';
import 'package:docdoc/presentation/widgets/home_widgets/speciality_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DoctorHomeCubit doctorCubit;
  late SpecializationsCubit specializationsCubit;
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    doctorCubit = DoctorHomeCubit()..getDoctors();
    specializationsCubit = SpecializationsCubit()..getSpecializations();
    userCubit = UserCubit()..fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: doctorCubit),
        BlocProvider.value(value: specializationsCubit),
        BlocProvider.value(value: userCubit),
      ],
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          width * 0.05,
          height * 0.07,
          width * 0.05,
          0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopWidget(),
              SizedBox(height: height * 0.03),
              FindNearbyWidget(),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doctor Speciality",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SpecializationsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.020),
              BlocBuilder<SpecializationsCubit, SpecializationStates>(
                builder: (context, state) {
                  if (state is SpecializationLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.blue,
                      ),
                    );
                  } else if (state is SpecializationSuccessState) {
                    return SpecialityWidget(
                      specializations: state.specializations,
                    );
                  } else if (state is SpecializationErrorState) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommendation Doctor",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RecDoctorScreen()),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.015),
              RecDoctorsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}