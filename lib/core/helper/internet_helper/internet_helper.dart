import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetHelper {
  Future<bool> get isConnected;
}

class InternetHelperImpl implements InternetHelper {
  final InternetConnectionChecker connectionChecker;

  InternetHelperImpl(this.connectionChecker);
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
