import 'package:dartz/dartz.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/features/signup/data/models/signup_model.dart';

abstract class SignupRepo {
  Future<Either<Failure, void>> registerNewUser(SignupModel signupModel);
}
