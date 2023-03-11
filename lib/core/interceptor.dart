import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'shared_preferences/app_shared_preferences.dart';
import '../features/user/data/models/user_response_model.dart';

class JwtInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await AppSharedPreferences.readUser("userData") != null) {
      String? token = UserResponseModel.fromJson(await AppSharedPreferences.readUser("userData")).accessToken;
      String bearerToken = 'Bearer $token';

      options.headers['Authorization'] = bearerToken;
    }
    options.headers['apikey'] = dotenv.env["API_KEY"];

    handler.next(options);
  }
}
