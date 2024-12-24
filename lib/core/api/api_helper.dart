import 'package:dio/dio.dart';

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
      required data,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> put(
      {required String endPoint,
      required data,
      Map<String, dynamic>? headers}) async {
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: data,
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
}
