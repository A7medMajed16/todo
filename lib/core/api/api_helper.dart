import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo/main.dart';

class ApiHelper {
  final String _baseUrl = "https://todo.iraqsapp.com";
  final Dio _dio;

  ApiHelper(this._dio);

  Future<Map<String, dynamic>> get(
      {required String endPoint, Map<String, dynamic>? headers}) async {
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<List<dynamic>> getList(
      {required String endPoint, Map<String, dynamic>? headers}) async {
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      options: Options(
        headers: headers,
      ),
    );

    return response.data;
  }

  Future<dynamic> post(
      {required String endPoint,
      required body,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      required body,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> del(
      {required String endPoint, Map<String, dynamic>? headers}) async {
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> uploadFile({
    required String endPoint,
    required File file,
    required String bodyKey,
    required String fileName,
    Map<String, dynamic>? headers,
  }) async {
    final formData = FormData.fromMap({
      bodyKey: await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: DioMediaType.parse('image/jpeg'),
      )
    });

    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: formData,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = await secureStorage!.read(key: "refresh_token");
      final accessToken = await secureStorage!.read(key: "access_token");
      var response = await _dio.get(
        '$_baseUrl/auth/refresh-token?token=$refreshToken',
        options: Options(
          headers: {"Authorization": "Bearer $accessToken"},
        ),
      );

      await secureStorage!.write(
        key: "access_token",
        value: response.data["access_token"],
      );
    } catch (e) {
      // Let the error propagate up to be handled by the calling function
      rethrow;
    }
  }
}
