import '../../../data/appointment_model.dart';

abstract class AppointmentGetState {}

class AppointmentGetInitialState extends AppointmentGetState {}

class AppointmentGetLoadingState extends AppointmentGetState {}

class AppointmentGetSuccessState extends AppointmentGetState {
  final List<AppointmentModel> appointments;
  AppointmentGetSuccessState(this.appointments);
}

class AppointmentGetErrorState extends AppointmentGetState {
  final String errorMessage;
  AppointmentGetErrorState(this.errorMessage);
}