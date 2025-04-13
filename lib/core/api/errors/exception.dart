class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
}

class CacheException implements Exception {
  final String errorMessage;

  CacheException({required this.errorMessage});
}

class OfflineException implements Exception {
  final String errorMessage;

  OfflineException({required this.errorMessage});
}
