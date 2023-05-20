import 'package:connectivity_plus/connectivity_plus.dart';

import '../../app/configuration.dart';
import '../dependency_registrar/dependencies.dart';

class HttpConfig {
  final Connectivity _connectivity = getIt();

  static String bearerToken = "";
  String getBaseUrl() => "https://${getIt<Configuration>().domain}";

  Map<String, String> getHeaders() => {};

  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
