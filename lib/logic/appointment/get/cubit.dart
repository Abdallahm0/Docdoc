import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/dio_helper.dart';
import '../../../core/api/url.dart';
import '../../../data/appointment_model.dart';
import 'state.dart';

class AppointmentGetCubit extends Cubit<AppointmentGetState> {
  AppointmentGetCubit() : super(AppointmentGetInitialState());

  List<AppointmentModel> appointments = [];

  void getAppointments() async {
    emit(AppointmentGetLoadingState());
    try {
      final response = await DioHelper.get(Url.appointmentUrl);

      if (DioHelper.isSuccess(response) && response.data['status'] == true) {
        final rawData = response.data['data'] as List?;
        appointments = rawData != null
            ? rawData.map((e) => AppointmentModel.fromJson(e)).toList()
            : [];
        emit(AppointmentGetSuccessState(appointments));
      } else {
        emit(AppointmentGetErrorState('Failed to fetch data: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AppointmentGetErrorState('Error: $e'));
    }
  }
}