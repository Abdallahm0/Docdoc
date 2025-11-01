import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/dio_helper.dart';
import '../../../core/api/url.dart';
import '../../../data/user_model.dart';
import 'state.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  Future<void> fetchUser() async {
    emit(UserLoadingState());

    try {
      final hasToken = await DioHelper.hasAuthToken();
      if (!hasToken) {
        emit(UserErrorState("No auth token found"));
        return;
      }

      final response = await DioHelper.get(
        Url.userProfileUrl,
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        final userData = UserModel.fromJson(response.data['data'][0]);
        emit(UserSuccessState(userData));
      } else if (response.statusCode == 401) {
        await DioHelper.clearAuthToken();
        emit(UserErrorState("Unauthorized, token cleared"));
      } else {
        emit(UserErrorState(
            "Failed to fetch user. Status code: ${response.statusCode}"));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

}