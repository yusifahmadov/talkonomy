part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final LoginHelperModel model;
  final dynamic whenSuccess;
  const LoginButtonPressed({required this.model, this.whenSuccess});
}
