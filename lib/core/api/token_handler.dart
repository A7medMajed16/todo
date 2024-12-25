import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:todo/core/api/api_helper.dart';
import 'package:todo/core/api/errors/failures.dart';

class TokenHandler {
  final ApiHelper _apiHelper;
  final int maxRetries = 5;

  TokenHandler(this._apiHelper);

  Future<Either<Failure, T>> executeWithToken<T>({
    required Future<T> Function() apiCall,
    bool shouldLogoutOn403 = true,
  }) async {
    int retryCount = 0;

    while (true) {
      try {
        final result = await apiCall();
        return right(result);
      } catch (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 401) {
            if (retryCount >= maxRetries) {
              return left(ServerFailure("Max refresh attempts reached"));
            }
            try {
              await _apiHelper.refreshToken();
              retryCount++;
              continue;
            } catch (refreshError) {
              if (refreshError is DioException &&
                  refreshError.response?.statusCode == 403 &&
                  shouldLogoutOn403) {
                return left(
                    ServerFailure("Session expired. Please login again."));
              }
              return left(_handleDioException(refreshError as DioException));
            }
          } else if (e.response?.statusCode == 403 && shouldLogoutOn403) {
            return left(ServerFailure("Session expired. Please login again."));
          }
          return left(_handleDioException(e));
        }
        return left(ServerFailure(e.toString()));
      }
    }
  }

  Failure _handleDioException(DioException e) {
    return ServerFailure.fromDioException(e);
  }
}
