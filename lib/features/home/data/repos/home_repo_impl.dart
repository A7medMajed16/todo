import 'package:dartz/dartz.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/core/api/token_handler.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/data/repos/home_repo.dart';
import 'package:todo/main.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiHelper _apiHelper;
  final TokenHandler _tokenHandler;

  HomeRepoImpl(this._apiHelper) : _tokenHandler = TokenHandler(_apiHelper);
  @override
  Future<Either<Failure, List<TaskModel>>> getTasks(
      {required int pageIndex}) async {
    return _tokenHandler.executeWithToken(
      apiCall: () async {
        final accessToken = await secureStorage!.read(key: "access_token");

        List<dynamic> response = await _apiHelper.getList(
          endPoint: "/todos?page=$pageIndex",
          headers: {"Authorization": "Bearer $accessToken"},
        );
        return response.map((item) => TaskModel.fromJson(item)).toList();
      },
    );
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String taskId}) async {
    final accessToken = await secureStorage!.read(key: "access_token");
    return _tokenHandler.executeWithToken(
      apiCall: () async {
        await _apiHelper.del(
          endPoint: "/todos/$taskId",
          headers: {"Authorization": "Bearer $accessToken"},
        );
      },
    );
  }
}
