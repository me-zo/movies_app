import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import 'errors.dart';

class ErrorHandler {
  static Future<Either<Failure, T>> handleFuture<T>(
    Future<Either<Failure, T>> Function() func,
    String errorMessage,
  ) async {
    try {
      return await func.call();
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (e) {
      return Left(
        Failure(
          message: errorMessage,
        ),
      );
    }
  }

  static Either<Failure, T> handle<T>(
    Either<Failure, T> Function() func,
    String errorMessage,
  ) {
    try {
      return func.call();
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (e) {
      return Left(
        Failure(
          message: errorMessage,
        ),
      );
    }
  }

  /// Checks for specific codes that require special attention
  /// Then handles the rest based on the HTTP Code level
  static Exception httpResponseException(Response response) {
    final Map<String, dynamic> json = jsonDecode(response.body);

    switch (response.statusCode) {
      case HttpStatus.forbidden:
        return UnauthorizedException(message: json['message'] ?? "");
      case HttpStatus.notFound:
        return NotFoundException(message: json['message'] ?? "");
      default:
        if (response.statusCode >= 400 && response.statusCode < 500) {
          return ClientErrorException(
            statusCode: response.statusCode,
            body: json['message'] ?? response.body,
          );
        } else if (response.statusCode >= 500) {
          return ServerErrorException(
            statusCode: response.statusCode,
            body: json['message'] ?? response.body,
          );
        } else {
          return Exception("UnhandledException Code: ${response.statusCode}"
              " body: ${json['message'] ?? response.body}");
        }
    }
  }

  static Failure _mapExceptionToFailure(Exception exception) {
    log(exception.toString());
    switch (exception.runtimeType) {
      case NoInternetException:
        exception as NoInternetException;
        return Failure(
          message: exception.message,
        );
      case UnauthorizedException:
        exception as UnauthorizedException;
        return Failure(
          message: exception.message,
        );
      case NotFoundException:
        exception as NotFoundException;
        return Failure(
          message: exception.message,
        );
      case ServerErrorException:
        exception as ServerErrorException;
        return Failure(
          message: exception.body,
        );
      case ClientErrorException:
        exception as ClientErrorException;
        return Failure(
          message: exception.body,
        );

      default:
        return Failure(
          message: "core.failures.unknownError",
        );
    }
  }
}
