part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailed extends SignupState {
  final ResponseModel failMessage;
  const SignupFailed({required this.failMessage});
}

class SignupCompleteSuccess extends SignupState {}

class SignupCompleteFailed extends SignupState {
  final ResponseModel failMessage;
  const SignupCompleteFailed({required this.failMessage});
}
