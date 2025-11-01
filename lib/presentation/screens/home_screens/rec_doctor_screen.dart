import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/data/doctor_model.dart';
import 'package:docdoc/logic/all_doctors/cubit.dart';
import 'package:docdoc/logic/all_doctors/state.dart';
import 'package:docdoc/presentation/screens/details_screens/about_screen.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecDoctorScreen extends StatefulWidget {
  const RecDoctorScreen({super.key});

  @override
  State<RecDoctorScreen> createState() => _RecDoctorScreenState();
}

class _RecDoctorScreenState extends State<RecDoctorScreen>
    with AutomaticKeepAliveClientMixin {
  late AllDoctorsHomeCubit doctorCubit;

  @override
  void initState() {
    super.initState();
    doctorCubit = AllDoctorsHomeCubit()..getDoctors();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: doctorCubit,
      child: Scaffold(
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
                  text: "All Doctors",
                ),
                SizedBox(height: size.height * 0.02),

                Expanded(
                  child: BlocBuilder<AllDoctorsHomeCubit, AllDoctorsState>(
                    builder: (context, state) {
                      if (state is AllDoctorsLoadingState) {
                        return  Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.blue,
                          ),
                        );
                      } else if (state is AllDoctorsErrorState) {
                        return Center(child: Text(state.errorMessage));
                      } else if (state is AllDoctorsSuccessState) {
                        final doctors = state.doctors;

                        if (doctors.isEmpty) {
                          return const Center(
                              child: Text("لا يوجد دكاترة متاحة"));
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = doctors[index];
                            return _buildDoctorItem(context, doctor, size);
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorItem(
      BuildContext context, DoctorModel doctor, Size size) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AboutScreen(doctor: doctor),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: size.height * 0.01),
        padding: EdgeInsets.all(size.width * 0.025),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                doctor.photo,
                height: size.height * 0.14,
                width: size.height * 0.14,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: size.height * 0.14,
                    width: size.height * 0.14,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: size.height * 0.07),
                  );
                },
              ),
            ),
            SizedBox(width: size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style:  TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ColorsManager.black,
                    ),
                  ),
                  Text(
                    doctor.specialization?.name ?? '',
                    style:  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '${doctor.degree} • ${doctor.city?.name ?? ''}',
                    style:  TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.grey,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Price : ${doctor.appointPrice} EGP',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}