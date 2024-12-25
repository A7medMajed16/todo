import 'package:dartz/dartz.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/features/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfileData();
}
