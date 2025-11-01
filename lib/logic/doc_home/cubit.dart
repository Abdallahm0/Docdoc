import 'package:docdoc/core/api/url.dart';
import 'package:docdoc/logic/doc_home/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/dio_helper.dart';
import '../../data/doctor_model.dart';

class DoctorHomeCubit extends Cubit<DoctorState> {
  DoctorHomeCubit() : super(DoctorInitialState());


  static DoctorHomeCubit get(context) => BlocProvider.of(context);


  List<DoctorModel> allDoctors = [];

  Future<void> getDoctors() async {

    if (state is DoctorSuccessState && allDoctors.isNotEmpty) return;

    emit(DoctorLoadingState());

    try {
      final hasToken = await DioHelper.hasAuthToken();
      if (!hasToken) {
        emit(DoctorErrorState('يجب تسجيل الدخول أولاً للوصول إلى البيانات'));
        return;
      }

      final response = await DioHelper.dio.get(Url.homeUrl);

      if (response.statusCode == 200) {
        final ApiResponse apiResponse = ApiResponse.fromJson(response.data);

        allDoctors.clear();
        for (var specialization in apiResponse.data) {
          allDoctors.addAll(specialization.doctors);
        }

        emit(DoctorSuccessState(allDoctors));
      } else if (response.statusCode == 401) {
        emit(DoctorErrorState('انتهت صلاحية الجلسة، يرجى تسجيل الدخول مرة أخرى'));
      } else {
        emit(DoctorErrorState('فشل تحميل البيانات: ${response.statusCode}'));
      }
    } catch (e) {
      emit(DoctorErrorState('حدث خطأ: $e'));
    }
  }


  Future<List<SpecializationWithDoctors>> getSpecializationsWithDoctors() async {
    try {
      final response = await DioHelper.dio.get(Url.homeUrl);

      if (response.statusCode == 200) {
        final ApiResponse apiResponse = ApiResponse.fromJson(response.data);
        return apiResponse.data;
      } else {
        throw Exception('فشل تحميل البيانات: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('حدث خطأ: $e');
    }
  }
}