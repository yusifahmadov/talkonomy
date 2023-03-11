part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  final SignupHelperModel model;
  const SignupButtonPressed({required this.model});
}

class SignupCompleteButtonPressed extends SignupEvent {
  final UpdateUserHelperModel model;
  final dynamic whenSuccess;
  const SignupCompleteButtonPressed({required this.model, this.whenSuccess});
}
