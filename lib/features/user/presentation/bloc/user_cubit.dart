import 'package:bloc/bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:talkonomy_app/core/shared_preferences/app_shared_preferences.dart';
import 'package:talkonomy_app/core/use_case_fetcher.dart';
import 'package:talkonomy_app/features/user/data/models/helper/update_user_helper_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_response_model.dart';
import 'package:talkonomy_app/features/user/domain/usecases/user_usecase.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUsecase _getUserUsecase;
  final UpdateUserUsecase _updateUserUsecase;
  UserCubit(this._getUserUsecase, this._updateUserUsecase) : super(UserInitial());

  final _userInformationController = BehaviorSubject<UserModel>();
  Stream<UserModel> get userInformationCont => _userInformationController.stream;

  updateUserInformationController() async {
    UserModel userData = UserResponseModel.fromJson(await AppSharedPreferences.readUser("userData")).user;
    _userInformationController.add(userData);
  }

  Future<UserModel> getAuthUserData({required String id}) async {
    final response = await _getUserUsecase(id);
    List<UserModel> data = [];
    response.fold((l) => [], (r) => data = r);
    return data[0];
  }

  updateUserInformation({required UpdateUserHelperModel model, whenSuccess}) async {
    await UseCaseFetcher.fetch(useCase: _updateUserUsecase, model: model, whenSuccess: whenSuccess);
  }

  @override
  Future<void> close() {
    _userInformationController.close();
    return super.close();
  }
}
