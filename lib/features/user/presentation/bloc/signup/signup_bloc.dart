import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/custom_flasher.dart';
import '../../../../../core/easy_loading/easy_loading.dart';
import '../../../../../core/response/response_model.dart';
import '../../../../../core/use_case_fetcher.dart';
import '../../../data/models/helper/signup_helper_model.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../auth/auth_bloc.dart';

import '../../../data/models/helper/update_user_helper_model.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignupUsecase _signupUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  final AuthBloc _authBloc;
  SignupBloc(this._signupUsecase, this._authBloc, this._updateUserUsecase) : super(SignupInitial()) {
    on<SignupButtonPressed>((event, emit) async {
      EasyLoad.show();
      final response = await _signupUsecase(event.model);
      response.fold((l) {
        EasyLoad.dismiss();
        CustomFlasher.showError(l.message);
        emit(SignupFailed(failMessage: l));
      }, (r) {
        _authBloc.add(LoggedIn(userData: r));
        EasyLoad.dismiss();

        emit(SignupSuccess());
      });
    });
    on<SignupCompleteButtonPressed>((event, emit) async {
      EasyLoad.show();

      final response = await _updateUserUsecase(event.model);
      await UseCaseFetcher.fetch(useCase: _updateUserUsecase, model: event.model, whenSuccess: event.whenSuccess);
      response.fold((l) async {
        EasyLoad.dismiss();
        CustomFlasher.showError("Xəta baş verdi!");
      }, (r) async {
        EasyLoad.dismiss();
      });
    });
  }
}
