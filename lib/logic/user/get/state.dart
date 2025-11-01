import '../../../data/user_model.dart';

class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserSuccessState extends UserStates {
  final UserModel user;
  UserSuccessState(this.user);
}

class UserErrorState extends UserStates {
  final String errorMessage;

  UserErrorState(this.errorMessage);
}