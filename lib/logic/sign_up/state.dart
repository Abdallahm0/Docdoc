class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final Map<String, dynamic> data;
  SignUpSuccessState(this.data);
}

class SignUpErrorState extends SignUpStates {
  final String errorMessage;

  SignUpErrorState(this.errorMessage);
}