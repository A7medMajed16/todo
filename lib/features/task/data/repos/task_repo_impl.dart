import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';
import 'package:todo/core/api/token_handler.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/task/data/repos/task_repo.dart';
import 'package:todo/main.dart';

class TaskRepoImpl implements TaskRepo {
  final ApiHelper _apiHelper;
  final TokenHandler _tokenHandler;

  TaskRepoImpl(this._apiHelper) : _tokenHandler = TokenHandler(_apiHelper);
  @override
  Future<Either<Failure, void>> addNewTask(TaskModel taskModel) async {
    final String? accessToken = await secureStorage!.read(key: "access_token");
    return _tokenHandler.executeWithToken(
        apiCall: () => _apiHelper.post(
            endPoint: "/todos",
            body: taskModel.toJson(),
            headers: {"Authorization": "Bearer $accessToken"}));
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskModel taskModel) async {
    final String? accessToken = await secureStorage!.read(key: "access_token");
    final String? userId = await secureStorage!.read(key: "user_id");
    return _tokenHandler.executeWithToken(
        apiCall: () =>
            _apiHelper.put(endPoint: "/todos/${taskModel.id}", body: {
              "image": taskModel.image,
              "title": taskModel.title,
              "desc": taskModel.desc,
              "priority": taskModel.priority,
              "status": taskModel.status,
              "user": userId
            }, headers: {
              "Authorization": "Bearer $accessToken"
            }));
  }

  @override
  Future<Either<Failure, String>> uploadImage({required File image}) async {
    final String? accessToken = await secureStorage!.read(key: "access_token");

    return _tokenHandler.executeWithToken(
      apiCall: () async {
        var response = await _apiHelper.uploadFile(
          endPoint: "/upload/image",
          file: image,
          bodyKey: 'image',
          fileName: image.path.split("/").last,
          headers: {
            "Authorization": "Bearer $accessToken",
            "Accept": "*/*",
          },
        );
        return response["image"];
      },
    );
  }
}
