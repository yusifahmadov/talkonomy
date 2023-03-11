import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_cubit.dart';
import 'features/user/domain/usecases/user_usecase.dart';
import 'features/user/presentation/bloc/signup/signup_bloc.dart';

import 'core/interceptor.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/presentation/bloc/auth/auth_bloc.dart';
import 'features/user/presentation/bloc/login/login_bloc.dart';

GetIt getIt = GetIt.instance;

init() async {
  initBlocs();
  initRepositories();
  initDataSources();
  initUseCases();
  await initExternals();
}

initBlocs() {
  getIt.registerFactory(() => SignupBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => AuthBloc());
  getIt.registerFactory(() => LoginBloc(getIt(), getIt()));
  getIt.registerFactory(() => UserCubit(
        getIt(),
        getIt(),
      ));
}

initRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(getIt()),
  );
}

initDataSources() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(getIt()),
  );
}

initUseCases() {
  getIt.registerLazySingleton(() => SignupUsecase(getIt()));
  getIt.registerLazySingleton(() => LoginUsecase(getIt()));
  getIt.registerLazySingleton(() => GetUserUsecase(getIt()));
  getIt.registerLazySingleton(() => UpdateUserUsecase(getIt()));
}

final navigatorKey = GlobalKey<NavigatorState>();
final ctx = navigatorKey.currentContext;
initExternals() {
  getIt.registerLazySingleton(() => navigatorKey);

  getIt.registerLazySingleton(() => Dio()..interceptors.add(JwtInterceptor()));
}
