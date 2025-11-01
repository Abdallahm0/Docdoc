import 'package:dio/dio.dart';
import 'package:docdoc/core/api/url.dart';
import 'package:docdoc/logic/user/post/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/dio_helper.dart';
import '../../../data/user_model.dart';


class UserPostCubit extends Cubit<UserPostState> {
  UserPostCubit() : super(UserPostInitial());

  static UserPostCubit get(context) => BlocProvider.of(context);

  Future<void> createUser(UserModel user) async {
    emit(UserPostLoading());

    try {
      final response = await DioHelper.dio.post(
        Url.userPostUrl,
        data: user.toJson(),
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['status'] == true) {
        final newUser = UserModel.fromJson(response.data['data']);
        emit(UserPostSuccess(newUser));
      } else {
        String errorMsg = "Failed to create user";
        if (response.data != null && response.data['data'] != null) {
          errorMsg = response.data['data'].toString();
        } else if (response.data != null && response.data['message'] != null) {
          errorMsg = response.data['message'].toString();
        }
        emit(UserPostError(errorMsg));
      }
    } catch (e) {
      emit(UserPostError(e.toString()));
    }
  }

}