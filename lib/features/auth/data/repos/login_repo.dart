import 'package:dartz/dartz.dart';
import 'package:todo/core/api/errors/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, void>> emailAndPasswordLogin(
      {required String phone, required String password});
  Future<Either<Failure, void>> logout();
}
