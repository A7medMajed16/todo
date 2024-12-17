import 'package:dio/dio.dart';

/// Abstract class representing a failure.
abstract class Failure {
  /// Error message associated with the failure.
  final String errorMessage;

  /// Constructor for Failure.
  ///
  /// @param errorMessage The error message.
  const Failure(this.errorMessage);
}

/// ServerFailure class extending Failure.
class ServerFailure extends Failure {
  /// Constructor for ServerFailure.
  ///
  /// @param errorMessage The error message.
  ServerFailure(super.errorMessage);

  /// Factory method to create a ServerFailure from a DioException.
  ///
  /// @param dioException The DioException to create the ServerFailure from.
  /// @return A ServerFailure instance.
  ///
  /// Example:
  /// ```dart
  /// DioException dioException = DioException(type: DioExceptionType.connectionTimeout);
  /// ServerFailure failure = ServerFailure.fromDioException(dioException);
  /// print(failure.errorMessage); // Output: Connection Timeout
  /// ```
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request Cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection Error');

      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unknown Error');
    }
  }

  /// Factory method to create a ServerFailure from a response.
  ///
  /// @param statusCode The status code of the response.
  /// @param response The response data.
  /// @return A ServerFailure instance.
  ///
  /// Example:
  /// ```dart
  /// int statusCode = 400;
  /// var response = {'message': 'Bad request'};
  /// ServerFailure failure = ServerFailure.fromResponse(statusCode, response);
  /// print(failure.errorMessage); // Output: Bad request
  /// ```
  factory ServerFailure.fromResponse(int statusCode, var response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message']);
    } else if (statusCode == 409) {
      return ServerFailure(response['message']);
    } else if (statusCode == 404) {
      if (response['message'] != null) {
        return ServerFailure(response['message']);
      } else {
        return ServerFailure('Your request note found, Please try later!');
      }
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error, Please try later!');
    } else if (statusCode == 422) {
      if (response["message"] != null && response["message"] is String) {
        return ServerFailure(response["message"]);
      } else {
        return ServerFailure(response["message"]["email"][0]);
      }
    } else {
      return ServerFailure('Oops there was an Error, Pleas try  again later!');
    }
  }
}
