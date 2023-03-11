import 'package:dartz/dartz.dart';
import '../../../../core/response/error_model.dart';
import '../../../../core/response/response_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/user_response_model.dart';

abstract class UserRepository {
  Future<Either<ResponseModel, UserResponseModel>> signUp(String email, String password);
  Future<Either<void, void>> updateUser(String id, String name, String surname, String age, bool verified);
  Future<Either<ErrorModel, UserResponseModel>> login(String email, String password);
  Future<Either<ResponseModel, List<UserModel>>> getUser(String id);
}
