import '../../../data/appointment_model.dart';

abstract class AppointmentPostState {}

class AppointmentPostInitialState extends AppointmentPostState {}

class AppointmentPostLoadingState extends AppointmentPostState {}

class AppointmentPostSuccessState extends AppointmentPostState {
  final AppointmentModel appointment;
  AppointmentPostSuccessState(this.appointment);
}

class AppointmentPostErrorState extends AppointmentPostState {
  final String errorMessage;
  AppointmentPostErrorState(this.errorMessage);
}