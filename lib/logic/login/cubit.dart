import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../core/helpers/dio_helper.dart';
import '../../core/helpers/shared_prefs_helper.dart';
import '../../core/api/url.dart';
import 'state.dart';

class LoginCubit extends Cubit<LoginsStates> {
  LoginCubit() : super(LoginsInitialState());

  final SharedPrefsHelper _prefsHelper = SharedPrefsHelper();

  Future<void> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(LoginsLoadingState());

    try {
      final response = await DioHelper.post(
        Url.loginUrl,
        data: {"email": email, "password": password},
      );

      print(" Login Response: ${response.data}");

      if (DioHelper.isSuccess(response)) {
        final token = response.data['data']?["token"];
        final username = response.data['data']?["username"];

        if (token != null && token.isNotEmpty) {
          await _prefsHelper.saveRegistrationToken(token);
          await _prefsHelper.saveRememberMe(rememberMe);

          if (token != null && token.isNotEmpty) {
            await _prefsHelper.saveRegistrationToken(token);
            await _prefsHelper.saveRememberMe(rememberMe);

            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
            final userId = decodedToken["sub"];
            if (userId != null) {
              await _prefsHelper.saveUserId(int.parse(userId.toString()));
            }

            await DioHelper.saveAuthToken(token);

            print(' تم حفظ التوكن: $token - والـ userId: $userId (RememberMe: $rememberMe)');
            emit(LoginsSuccessState(response.data));
          }

        } else {
          emit(LoginsErrorState("لم يتم العثور على التوكن في الاستجابة"));
        }

      } else {
        emit(LoginsErrorState("خطأ غير متوقع: ${response.statusCode}"));
      }
    } catch (e) {
      emit(LoginsErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LoginsLoadingState());
    await _prefsHelper.clearRegistrationToken();
    emit(LoginsSuccessState({"message": "تم تسجيل الخروج"}));
  }

  Future<bool> isLoggedIn() async {
    final token = await _prefsHelper.getRegistrationToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> getRememberMe() async {
    return await _prefsHelper.getRememberMe();
  }
}