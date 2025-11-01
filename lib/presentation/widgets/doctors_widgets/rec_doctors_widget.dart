import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/data/doctor_model.dart';
import 'package:docdoc/logic/doc_home/state.dart';
import 'package:docdoc/presentation/screens/details_screens/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/doc_home/cubit.dart';

class RecDoctorsWidget extends StatefulWidget {
  final List<DoctorModel>? doctors;
  final String searchQuery;

  const RecDoctorsWidget({
    super.key,
    this.doctors,
    this.searchQuery = '',
  });

  @override
  State<RecDoctorsWidget> createState() => _RecDoctorsWidgetState();
}

class _RecDoctorsWidgetState extends State<RecDoctorsWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final doctorsFromParam = widget.doctors;

    if (doctorsFromParam != null) {
      return _buildDoctorsList(doctorsFromParam, width, height);
    }

    return BlocBuilder<DoctorHomeCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorLoadingState) {
          return Center(
            child: CircularProgressIndicator(color: ColorsManager.blue),
          );
        } else if (state is DoctorErrorState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is DoctorSuccessState) {
          return _buildDoctorsList(state.doctors, width, height);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildDoctorsList(
      List<DoctorModel> doctors, double width, double height) {
    final filteredDoctors = doctors.where((doctor) {
      final query = widget.searchQuery.toLowerCase();
      return doctor.name.toLowerCase().contains(query) ||
          doctor.specialization!.name.toLowerCase().contains(query) ||
          doctor.city!.name.toLowerCase().contains(query);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = filteredDoctors[index];
        return _buildDoctorItem(context, doctor, width, height);
      },
    );
  }

  Widget _buildDoctorItem(
      BuildContext context, DoctorModel doctor, double width, double height) {
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
        margin: EdgeInsets.only(bottom: height * 0.010),
        padding: EdgeInsets.all(width * 0.025),
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
                height: height * 0.14,
                width: height * 0.14,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height * 0.14,
                    width: height * 0.14,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: height * 0.07),
                  );
                },
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: ColorsManager.black,
                    ),
                  ),
                  Text(
                    doctor.specialization!.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    '${doctor.degree} • ${doctor.city!.name}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.grey,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
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

  @override
  bool get wantKeepAlive => true;
}