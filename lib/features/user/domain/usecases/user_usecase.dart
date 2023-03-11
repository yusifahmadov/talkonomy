import 'package:talkonomy_app/features/user/data/models/user_model.dart';

import '../../../../core/response/error_model.dart';
import '../../../../core/response/response_model.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/helper/login_helper_model.dart';
import '../../data/models/user_response_model.dart';
import '../repositories/user_repository.dart';

import '../../../../core/use_case/use_case.dart';
import '../../data/models/helper/signup_helper_model.dart';
import '../../data/models/helper/update_user_helper_model.dart';

class SignupUsecase extends Usecase<UserResponseModel, SignupHelperModel> {
  final UserRepository _userRepository;
  SignupUsecase(this._userRepository);
  @override
  Future<Either<ResponseModel, UserResponseModel>> call(params) {
    return _userRepository.signUp(params.email, params.password);
  }
}

class UpdateUserUsecase extends Usecase<void, UpdateUserHelperModel> {
  final UserRepository _userRepository;
  UpdateUserUsecase(this._userRepository);
  @override
  Future<Either<void, void>> call(params) {
    return _userRepository.updateUser(params.id, params.name, params.surname, params.age, true);
  }
}

class LoginUsecase extends Usecase<UserResponseModel, LoginHelperModel> {
  final UserRepository _userRepository;
  LoginUsecase(this._userRepository);
  @override
  Future<Either<ErrorModel, UserResponseModel>> call(params) {
    return _userRepository.login(params.email, params.password);
  }
}

class GetUserUsecase extends Usecase<List<UserModel>, String> {
  final UserRepository _userRepository;
  GetUserUsecase(this._userRepository);
  @override
  Future<Either<ResponseModel, List<UserModel>>> call(params) {
    return _userRepository.getUser(params);
  }
}
