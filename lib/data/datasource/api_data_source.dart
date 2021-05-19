import 'package:satorio/data/model/profile_model.dart';

abstract class ApiDataSource {
  Future<bool> isTokenExist();

  Future<bool> signIn(String email, String password);

  Future<bool> signUp(String email, String password, String username);

  Future<bool> refreshToken();

  Future<ProfileModel> profile();
}
