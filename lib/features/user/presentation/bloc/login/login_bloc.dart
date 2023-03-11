import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talkonomy_app/core/custom_flasher.dart';
import 'package:talkonomy_app/core/easy_loading/easy_loading.dart';
import 'package:talkonomy_app/features/user/data/models/helper/login_helper_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/domain/usecases/user_usecase.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _loginUsecase;
  final AuthBloc _authBloc;
  LoginBloc(this._loginUsecase, this._authBloc) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      EasyLoad.show();
      final response = await _loginUsecase(event.model);
      response.fold((l) async {
        EasyLoad.dismiss();
        CustomFlasher.showError(l.errorDescription);
        emit(LoginFailed());
      }, (r) async {
        EasyLoad.dismiss();

        _authBloc.add(LoggedIn(userData: r));

        emit(LoginSuccess(data: r.user));
      });
    });
  }
}
