class LoginsStates {}

class LoginsInitialState extends LoginsStates {}

class LoginsLoadingState extends LoginsStates {}

class LoginsSuccessState extends LoginsStates {
  final Map<String, dynamic> data;
  LoginsSuccessState(this.data);
}

class LoginsErrorState extends LoginsStates {
  final String errorMessage;

  LoginsErrorState(this.errorMessage);
}