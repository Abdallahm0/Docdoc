import 'package:docdoc/core/api/url.dart';
import 'package:docdoc/logic/all_doctors/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/dio_helper.dart';
import '../../data/all_doctors.dart';
import '../../data/doctor_model.dart';

class AllDoctorsHomeCubit extends Cubit<AllDoctorsState> {
  AllDoctorsHomeCubit() : super(AllDoctorsInitialState());

  static AllDoctorsHomeCubit get(context) => BlocProvider.of(context);

  List<DoctorModel> allDoctors = [];

  Future<void> getDoctors() async {
    if (state is AllDoctorsSuccessState && allDoctors.isNotEmpty) return;

    emit(AllDoctorsLoadingState());

    try {
      final hasToken = await DioHelper.hasAuthToken();
      if (!hasToken) {
        emit(AllDoctorsErrorState('يجب تسجيل الدخول أولاً للوصول إلى البيانات'));
        return;
      }

      final response = await DioHelper.dio.get(Url.doctorUrl);

      if (response.statusCode == 200) {
        final DoctorsResponse doctorsResponse = DoctorsResponse.fromJson(response.data);

        allDoctors.clear();
        allDoctors.addAll(doctorsResponse.data);

        emit(AllDoctorsSuccessState(allDoctors));
      } else if (response.statusCode == 401) {
        emit(AllDoctorsErrorState('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى'));
      } else {
        emit(AllDoctorsErrorState('فشل تحميل البيانات: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AllDoctorsErrorState('حدث خطأ: $e'));
    }
  }

}