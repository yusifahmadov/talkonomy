import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:talkonomy_app/features/user/data/models/user_model.dart';
import '../models/user_response_model.dart';
part 'user_remote_data_source.g.dart';

abstract class UserRemoteDataSource {
  Future<UserResponseModel> signUp(String email, String password);
  Future<void> updateUser(String id, String name, String surname, String age, bool verified);
  Future<UserResponseModel> login(String email, String password);
  Future<List<UserModel>> getUser(String id);
}

@RestApi(baseUrl: "https://srdgvldpnwzjhheyhdzw.supabase.co")
abstract class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  factory UserRemoteDataSourceImpl(Dio dio, {String baseUrl}) = _UserRemoteDataSourceImpl;

  @override
  @POST("/auth/v1/signup")
  Future<UserResponseModel> signUp(@Field("email") String email, @Field("password") String password);

  @override
  @PATCH("/rest/v1/profile?id=eq.{id}")
  Future<void> updateUser(@Path("id") String id, @Field("name") String name, @Field("surname") String surname, @Field("age") String age,
      @Field("verified") bool verified);

  @override
  @POST("/auth/v1/token?grant_type=password")
  Future<UserResponseModel> login(@Field("email") String email, @Field("password") String password);

  @override
  @GET("/rest/v1/profile?id=eq.{id}&select=*")
  Future<List<UserModel>> getUser(@Path("id") String id);
}
