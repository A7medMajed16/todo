import 'package:dartz/dartz.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/core/api/token_handler.dart';
import 'package:todo/features/profile/data/models/profile_model.dart';
import 'package:todo/features/profile/data/repos/profile_repo.dart';
import 'package:todo/main.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiHelper _apiHelper;
  final TokenHandler _tokenHandler;

  ProfileRepoImpl(this._apiHelper) : _tokenHandler = TokenHandler(_apiHelper);
  @override
  Future<Either<Failure, ProfileModel>> getProfileData() async {
    return _tokenHandler.executeWithToken(
      apiCall: () async {
        final String? accessToken =
            await secureStorage!.read(key: "access_token");

        var result = await _apiHelper.get(
            endPoint: "/auth/profile",
            headers: {"Authorization": "Bearer $accessToken"});
        return ProfileModel.fromJson(result);
      },
    );
  }
}
