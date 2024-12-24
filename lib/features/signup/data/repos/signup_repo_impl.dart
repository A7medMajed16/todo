import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/features/signup/data/models/signup_model.dart';
import 'package:todo/features/signup/data/repos/signup_repo.dart';

class SignupRepoImpl implements SignupRepo {
  final ApiHelper _apiHelper;

  SignupRepoImpl(this._apiHelper);
  @override
  Future<Either<Failure, void>> registerNewUser(SignupModel signupModel) async {
    try {
      await _apiHelper.post(
          endPoint: "/auth/register", data: signupModel.toJson());
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
}
