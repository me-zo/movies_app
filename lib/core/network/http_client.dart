import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';
import 'package:movies_app/secrets/secrets.dart';

import '../dependency_registrar/dependencies.dart';
import '../failures/errors.dart';

class HttpClient {
  final Connectivity _connectivity = sl();

  Future<Response> postData({
    required String url,
    required String body,
  }) async {
    if (await _isConnected()) {
      var finalUrl = Uri.parse("${getBaseUrl()}/$url");

      log("Posting To: $finalUrl");
      var result = await post(
        finalUrl,
        headers: _getHeaders(),
        body: body,
      );
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<Response> putData({
    required String url,
    required String body,
  }) async {
    if (await _isConnected()) {
      var finalUrl = Uri.parse("${getBaseUrl()}/$url");

      log("Putting To: $finalUrl");

      var result = await put(
        finalUrl,
        headers: _getHeaders(),
        body: body,
      );
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<Response> getData({
    required String url,
  }) async {
    if (await _isConnected()) {
      var finalUrl = Uri.parse("${getBaseUrl()}/$url");

      log("Getting From: $finalUrl");
      var result = await get(
        finalUrl,
        headers: _getHeaders(),
      );

      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  static String getBaseUrl() {
    return "http://www.omdbapi.com";
  }

  static Map<String, String> _getHeaders() {
    var headers = {'Content-Type': 'application/json-patch+json'};
    headers.addAll({
    "apikey" : Secrets.apiKey
    });
    return headers;
  }

  Future<bool> _isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
