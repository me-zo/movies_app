import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/secrets/secrets.dart';

import '../errors/errors.dart';
import '../utils/logger.dart';
import 'http_config.dart';

class HttpClient {
  final HttpConfig config;

  HttpClient({required this.config});

  Future<http.Response> post({
    required String url,
    required String body,
    Map<String, String>? query,
  }) async {
    if (await config.isConnected()) {
      var finalUrl =
          Uri.parse("${config.getBaseUrl()}/?&apikey=${Secrets.apiKey}$url")
              .replace(queryParameters: query);
      var headers = config.getHeaders();
      Log.d("Posting To: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}");
      http.Response result = await http.post(
        finalUrl,
        headers: config.getHeaders(),
        body: body,
      );
      Log.d("Response code: ${result.statusCode}"
          "\nResponse headers: ${result.headers}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<http.Response> get(
      {required String url, Map<String, String>? query}) async {
    if (await config.isConnected()) {
      var finalUrl =
          Uri.parse("${config.getBaseUrl()}/?&apikey=${Secrets.apiKey}$url")
              .replace(queryParameters: query);
      var headers = config.getHeaders();
      Log.d("Getting From: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}");
      var result = await http.get(
        finalUrl,
        headers: headers,
      );
      Log.d("Response code: ${result.statusCode}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }

  Future<http.Response> put({
    required String url,
    required String body,
  }) async {
    if (await config.isConnected()) {
      var finalUrl =
          Uri.parse("${config.getBaseUrl()}/?&apikey=${Secrets.apiKey}$url");
      var headers = config.getHeaders();
      Log.d("Putting To: $finalUrl"
          "\nRequest headers: ${const JsonEncoder.withIndent("    ").convert(headers)}"
          "\nRequest body: $body");
      var result = await http.put(
        finalUrl,
        headers: headers,
        body: body,
      );

      Log.d("Response code: ${result.statusCode}"
          "\nResponse headers: ${result.headers}"
          "\nResponse body: ${result.body}");
      return result;
    } else {
      throw NoInternetException("core.network.NoInternetConnection");
    }
  }
}
