import 'package:bloc/bloc.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/domain/usecases/user_usecase.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final GetUserUsecase _getUserUsecase;
  UserCubit(this._getUserUsecase) : super(UserInitial());

  Future<UserModel> getAuthUserData({required String id}) async {
    final response = await _getUserUsecase(id);
    List<UserModel> data = [];
    response.fold((l) => [], (r) => data = r);
    return data[0];
  }
}
