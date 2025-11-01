import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/doc_home/cubit.dart';
import '../../logic/speciality/cubit.dart';
import '../../presentation/screens/home_screens/home_screen.dart';
import '../../presentation/screens/profile_screens/profile_screen.dart';
import '../../presentation/widgets/custom_bottom_nav_bar.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;

  late DoctorHomeCubit doctorCubit;
  late SpecializationsCubit specializationsCubit;

  final List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    doctorCubit = DoctorHomeCubit()..getDoctors();
    specializationsCubit = SpecializationsCubit()..getSpecializations();

    screens.addAll([
      BlocProvider.value(
        value: doctorCubit,
        child: BlocProvider.value(
          value: specializationsCubit,
          child: const HomeScreen(),
        ),
      ),
      const ProfileScreen(),
    ]);
  }

  void onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTabChanged: onTabChanged,
      ),
    );
  }
}