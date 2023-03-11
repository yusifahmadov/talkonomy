import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/presentation/bloc/user_cubit.dart';
import '../../../../../core/shared_preferences/app_shared_preferences.dart';
import '../../../../../injection.dart';
import '../../../data/models/user_response_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      if (await AppSharedPreferences.readUser("userData") != null) {
        UserResponseModel userData = UserResponseModel.fromJson(await AppSharedPreferences.readUser("userData"));

        if (userData.user.verified == true) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthNotAuthenticated());
        }
      } else {
        emit(AuthNotAuthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      print(event.userData.user.id);
      UserModel userData = await getIt<UserCubit>().getAuthUserData(id: event.userData.user.id!);
      UserResponseModel userResponseModel = UserResponseModel(
          accessToken: event.userData.accessToken,
          refreshToken: event.userData.refreshToken,
          user: UserModel(
              id: userData.id,
              name: userData.name,
              surname: userData.surname,
              age: userData.age,
              profileImage: userData.profileImage,
              verified: userData.verified));
      await AppSharedPreferences.saveUser("userData", userResponseModel);
      emit(AuthAuthenticated());
    });
    on<LoggedOut>(
      (event, emit) async {
        emit(AuthLoading());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("userData");
        emit(AuthNotAuthenticated());
      },
    );
  }
}
