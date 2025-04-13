import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Abstract class representing a failure.
abstract class Failure extends Equatable {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errorMessage);

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

  @override
  List<Object?> get props => [];
}

class OfflineFailures extends Failure {
  const OfflineFailures(super.errorMessage);

  @override
  List<Object?> get props => [];
}

class CacheFailures extends Failure {
  const CacheFailures(super.errorMessage);

  @override
  List<Object?> get props => [];
}
