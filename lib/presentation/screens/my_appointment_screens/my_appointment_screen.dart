import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:docdoc/core/utils/colors.dart';
import 'package:docdoc/presentation/widgets/top_bar.dart';
import '../../../logic/appointment/get/cubit.dart';
import '../../../logic/appointment/get/state.dart';
import '../../../data/appointment_model.dart';
import '../../widgets/my_appointment_widgets/doctor_card.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => AppointmentGetCubit()..getAppointments(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: ColorsManager.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06,
                vertical: size.width * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopBar(text: "My Appointment"),
                  SizedBox(height: size.height * 0.03),

                  const TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Upcoming"),
                      Tab(text: "Completed"),
                      Tab(text: "Cancelled"),
                    ],
                  ),

                  SizedBox(height: size.height * 0.02),

                  Expanded(
                    child:
                        BlocBuilder<AppointmentGetCubit, AppointmentGetState>(
                          builder: (context, state) {
                            if (state is AppointmentGetLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ColorsManager.blue,
                                ),
                              );
                            } else if (state is AppointmentGetErrorState) {
                              return Center(child: Text(state.errorMessage));
                            } else if (state is AppointmentGetSuccessState) {
                              final appointments = state.appointments;

                              final upcomingAppointments = appointments
                                  .where(
                                    (a) =>
                                        a.status == AppointmentStatus.pending ||
                                        a.status == AppointmentStatus.upcoming,
                                  )
                                  .toList();

                              final completedAppointments = appointments
                                  .where(
                                    (a) =>
                                        a.status == AppointmentStatus.completed,
                                  )
                                  .toList();

                              final cancelledAppointments = appointments
                                  .where(
                                    (a) =>
                                        a.status == AppointmentStatus.cancelled,
                                  )
                                  .toList();

                              return TabBarView(
                                children: [
                                  AppointmentList(
                                    appointments: upcomingAppointments,
                                  ),
                                  AppointmentList(
                                    appointments: completedAppointments,
                                  ),
                                  AppointmentList(
                                    appointments: cancelledAppointments,
                                  ),
                                ],
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
      ),
    );
  }
}

class AppointmentList extends StatelessWidget {
  final List<AppointmentModel> appointments;

  const AppointmentList({super.key, required this.appointments});

  String formatDate(DateTime dateTime) {
    return DateFormat("EEEE, MMMM d, y h:mm a", "en_US").format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(child: Text("No appointments found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        final doctor = appointment.doctor;
        return DoctorAppointmentCard(
          doctorName: doctor.name,
          specialization: doctor.specialization?.name ?? "",
          degree: doctor.degree,
          city: doctor.city?.name ?? "",
          price: doctor.appointPrice.toDouble(),
          imageUrl: doctor.photo,
          onCancel: () {
            print("Cancel Appointment ${appointment.id}");
          },
          onEdit: () {
            print("Reschedule Appointment ${appointment.id}");
          },
        );

      },
    );

  }
}