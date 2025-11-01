import 'package:docdoc/data/doctor_model.dart';

class SpecializationStates {}

class SpecializationInitialState extends SpecializationStates {}

class SpecializationLoadingState extends SpecializationStates {}

class SpecializationSuccessState extends SpecializationStates {
  final List<SpecializationWithDoctors> specializations;

  SpecializationSuccessState(this.specializations);
}

class SpecializationErrorState extends SpecializationStates {
  final String errorMessage;

  SpecializationErrorState(this.errorMessage);
}