import 'package:docdoc/logic/speciality/cubit.dart';
import 'package:docdoc/logic/speciality/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import 'doctors_by_specialization_screen.dart';

class SpecializationsScreen extends StatefulWidget {
  const SpecializationsScreen({super.key});

  @override
  State<SpecializationsScreen> createState() => _SpecializationsScreenState();
}

class _SpecializationsScreenState extends State<SpecializationsScreen>
    with AutomaticKeepAliveClientMixin {
  late SpecializationsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SpecializationsCubit()..getSpecializations();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.02,
            ),
            child: Column(
              children: [
                TopBar(
                  text: "Medical Specializations",
                ),
                SizedBox(height: size.height * 0.02),
                Expanded(
                  child: BlocBuilder<SpecializationsCubit, SpecializationStates>(
                    builder: (context, state) {
                      if (state is SpecializationLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorsManager.blue,
                          ),
                        );
                      } else if (state is SpecializationSuccessState) {
                        final specializations = state.specializations;

                        return GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 70,
                            crossAxisSpacing: 25,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: specializations.length,
                          itemBuilder: (context, index) {
                            final spec = specializations[index];
                            return GestureDetector(
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
                                decoration: BoxDecoration(
                                  color: ColorsManager.white2,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: Center(
                                  child: Text(
                                    spec.name,
                                    style: TextStyle(
                                      color: ColorsManager.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is SpecializationErrorState) {
                        return Center(child: Text(state.errorMessage));
                      } else {
                        return const SizedBox();
                      }
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

  @override
  bool get wantKeepAlive => true;
}