import 'package:docdoc/logic/speciality/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/dio_helper.dart';
import '../../core/api/url.dart';
import '../../data/doctor_model.dart';

class SpecializationsCubit extends Cubit<SpecializationStates> {
  SpecializationsCubit() : super(SpecializationInitialState());

  static SpecializationsCubit get(context) => BlocProvider.of(context);

  List<SpecializationWithDoctors> allSpecializations = [];

  Future<void> getSpecializations() async {

    if (state is SpecializationSuccessState && allSpecializations.isNotEmpty) return;

    emit(SpecializationLoadingState());

    try {
      final response = await DioHelper.get(Url.specializationUrl);

      if (response.statusCode == 200) {

        final List<dynamic> rawData = response.data['data'];
        allSpecializations = rawData
            .map((e) => SpecializationWithDoctors.fromJson(e))
            .toList();

        emit(SpecializationSuccessState(allSpecializations));
      } else {
        emit(SpecializationErrorState('فشل تحميل البيانات: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SpecializationErrorState('حدث خطأ: $e'));
    }
  }
}