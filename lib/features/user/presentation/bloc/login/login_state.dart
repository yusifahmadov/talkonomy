part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel data;
  const LoginSuccess({required this.data});
}

class LoginFailed extends LoginState {}
