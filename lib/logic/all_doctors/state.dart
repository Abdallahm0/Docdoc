import 'package:docdoc/data/doctor_model.dart';

class AllDoctorsState {}

class AllDoctorsInitialState extends AllDoctorsState {}

class AllDoctorsLoadingState extends AllDoctorsState {}

class AllDoctorsSuccessState extends AllDoctorsState {
  final List<DoctorModel> doctors;

  AllDoctorsSuccessState(this.doctors);
}

class AllDoctorsErrorState extends AllDoctorsState {
  final String errorMessage;

  AllDoctorsErrorState(this.errorMessage);
}