import 'package:dio/dio.dart';
import 'package:talkonomy_app/core/response/error_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';

import '../models/user_response_model.dart';
import '../../../../core/response/response_model.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/user_repository.dart';

import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  UserRepositoryImpl(this._userRemoteDataSource);
  @override
  Future<Either<ResponseModel, UserResponseModel>> signUp(String email, String password) async {
    try {
      return Right(await _userRemoteDataSource.signUp(email, password));
    } on DioError catch (e) {
      return Left(ResponseModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<Either<void, void>> updateUser(String id, String name, String surname, String age, bool verified) async {
    try {
      return Right(await _userRemoteDataSource.updateUser(id, name, surname, age, verified));
    } on DioError catch (e) {
      return Left(ResponseModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<Either<ErrorModel, UserResponseModel>> login(String email, String password) async {
    try {
      return Right(await _userRemoteDataSource.login(email, password));
    } on DioError catch (e) {
      return Left(ErrorModel.fromJson(e.response!.data));
    }
  }

  @override
  Future<Either<ResponseModel, List<UserModel>>> getUser(String id) async {
    try {
      return Right(await _userRemoteDataSource.getUser(id));
    } on DioError catch (e) {
      return Left(ResponseModel.fromJson(e.response!.data));
    }
  }
}
