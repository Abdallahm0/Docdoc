import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/dio_helper.dart';
import '../../../core/api/url.dart';
import '../../../data/appointment_model.dart';
import 'state.dart';

class AppointmentPostCubit extends Cubit<AppointmentPostState> {
  AppointmentPostCubit() : super(AppointmentPostInitialState());

  void createAppointment({required AppointmentModel appointment}) async {
    emit(AppointmentPostLoadingState());
    try {
      final formattedTime = DioHelper.formatAppointment(appointment.appointmentTime);
      final formattedEndTime = DioHelper.formatAppointment(appointment.appointmentEndTime);

      final response = await DioHelper.post(
        Url.appointmentStoreUrl,
        data: {
          'doctor_id': appointment.doctor.id,
          'appointment_time': formattedTime,
          'appointment_end_time': formattedEndTime,
          'notes': appointment.notes,
          'appointment_price': appointment.appointmentPrice,
          'patient_id': appointment.patient.id,
        },
      );

      if (DioHelper.isSuccess(response) && response.data['status'] == true) {
        final newAppointment = AppointmentModel.fromJson(response.data['data']);
        emit(AppointmentPostSuccessState(newAppointment));
      } else {
        emit(AppointmentPostErrorState('Failed to create appointment: ${response.data['message'] ?? response.statusCode}'));
      }
    } catch (e) {
      emit(AppointmentPostErrorState('Error: $e'));
    }
  }
}