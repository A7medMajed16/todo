import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/core/api/token_handler.dart';
import 'package:todo/features/auth/data/repos/login_repo.dart';
import 'package:todo/main.dart';

class LoginRepoImpl implements LoginRepo {
  final ApiHelper _apiHelper;
  final TokenHandler _tokenHandler;
  LoginRepoImpl(this._apiHelper) : _tokenHandler = TokenHandler(_apiHelper);
  @override
  Future<Either<Failure, void>> emailAndPasswordLogin(
      {required String phone, required String password}) async {
    try {
      var response = await _apiHelper.post(
          endPoint: "/auth/login",
          body: {"phone": phone, "password": password});
      await secureStorage!
          .write(key: "access_token", value: response["access_token"]);
      await secureStorage!
          .write(key: "refresh_token", value: response["refresh_token"]);
      return right(null);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  @override
  Future<Either<Failure, void>> logout() async {
    final refreshToken = await secureStorage!.read(key: "refresh_token");
    final accessToken = await secureStorage!.read(key: "access_token");

    return _tokenHandler.executeWithToken(
      apiCall: () async {
        await _apiHelper.post(
          endPoint: "/auth/logout",
          body: {"token": refreshToken},
          headers: {"Authorization": "Bearer $accessToken"},
        );
        await _clearTokens();
      },
    );
  }

  Future<void> _clearTokens() async {
    await secureStorage!.delete(key: "access_token");
    await secureStorage!.delete(key: "refresh_token");
  }
}
