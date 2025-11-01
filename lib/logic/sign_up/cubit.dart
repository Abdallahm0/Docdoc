import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helpers/dio_helper.dart';
import '../../core/helpers/shared_prefs_helper.dart';
import '../../core/api/url.dart';
import 'state.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  final SharedPrefsHelper _prefsHelper = SharedPrefsHelper();

  Future<void> signUp({
    required String email,
    required String password,
    required String password_confirmation,
    required String name,
    required String phone,
    required String gender,
    bool rememberMe = false,
  }) async {
    emit(SignUpLoadingState());

    try {
      final response = await DioHelper.post(
        Url.registerUrl,
        data: {
          "email": email,
          "password": password,
          "password_confirmation": password_confirmation,
          "name": name,
          "phone": phone,
          "gender": gender,
        },
      );

      if (DioHelper.isSuccess(response)) {
        final token = response.data['data']?["token"];

        if (token != null && token.isNotEmpty) {
          await _prefsHelper.saveRegistrationToken(token);
          await _prefsHelper.saveRememberMe(rememberMe);

          await DioHelper.saveAuthToken(token);

          print(' تم حفظ التوكن بعد التسجيل: $token (RememberMe: $rememberMe)');
        } else {
          print("️ لم يتم العثور على التوكن في استجابة التسجيل");
        }

        emit(SignUpSuccessState(response.data));
      } else {
        emit(SignUpErrorState("خطأ غير متوقع: ${response.statusCode}"));
      }
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }

  Future<bool> getRememberMe() async {
    return await _prefsHelper.getRememberMe();
  }

  Future<String?> getToken() async {
    return await _prefsHelper.getRegistrationToken();
  }
}