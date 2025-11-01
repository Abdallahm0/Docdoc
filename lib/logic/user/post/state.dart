import '../../../data/user_model.dart';

abstract class UserPostState {}

class UserPostInitial extends UserPostState {}

class UserPostLoading extends UserPostState {}

class UserPostSuccess extends UserPostState {
  final UserModel user;
  UserPostSuccess(this.user);
}

class UserPostError extends UserPostState {
  final String message;

  UserPostError(this.message);
}