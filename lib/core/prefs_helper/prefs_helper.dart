import 'package:talkonomy_app/core/shared_preferences/app_shared_preferences.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import 'package:talkonomy_app/features/user/data/models/user_response_model.dart';

class PrefsHelper {
  static Future<bool> userIsVerified() async {
    UserModel userData = UserResponseModel.fromJson(await AppSharedPreferences.readUser("userData")).user;
    print(userData.name);
    return userData.verified!;
  }
}
