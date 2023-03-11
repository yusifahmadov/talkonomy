import 'package:dartz/dartz.dart';

abstract class Usecase<Type, Params> {
  Future<Either<dynamic, Type>> call(Params params);
}
