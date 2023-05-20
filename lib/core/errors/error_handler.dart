import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:movies_app/app/configuration.dart';

import '../dependency_registrar/dependencies.dart';
import '../utils/logger.dart';
import 'errors.dart';

class ErrorHandler {
  /// handles all exceptions that may happen when making a request
  static Future<Either<Failure, T>> handleFuture<T>(
    Future<Either<Failure, T>> Function() func,
  ) async {
    try {
      return await func.call();
    } on Exception catch (e) {
      return Left(_mapExceptionToFailure(e));
    } on Failure catch (f) {
      Log.e(f.toString());
      return Left(f);
    } on Error catch (e) {
      Log.e(e);
      return Left(
        Failure(
          message: e.toString(),
        ),
      );
    } catch (e) {
      Log.e(e);
      return Left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }

  /// Checks for specific codes that require special attention
  /// Then handles the rest based on the HTTP Code level
  static Exception httpResponseException(
    Response response, {
    bool handleClientErrors = true,
    bool handleServerErrors = true,
  }) {
    switch (response.statusCode) {
      case HttpStatus.forbidden:
        return UnauthorizedException(message: response.body);
      case HttpStatus.notFound:
        return NotFoundException(message: response.body);
      default:
        if (handleClientErrors &&
            response.statusCode >= 400 &&
            response.statusCode < 500) {
          return ClientErrorException(
            statusCode: response.statusCode,
            body: response.body,
          );
        } else if (handleServerErrors && response.statusCode >= 500) {
          return ServerErrorException(
            statusCode: response.statusCode,
            body: response.body,
          );
        } else {
          return Exception(
              "UnhandledNetworkException \n\tCode: ${response.statusCode} \n\tbody: ${response.body}");
        }
    }
  }

  /// maps possible exceptions to be shown in the form of a failure message
  static Failure _mapExceptionToFailure(Exception exception) {
    Log.e(exception);
    switch (exception.runtimeType) {
      case NoInternetException:
        exception as NoInternetException;
        return Failure(message: exception.message);
      case UnauthorizedException:
        exception as UnauthorizedException;
        return Failure(message: exception.message);
      case NotFoundException:
        exception as NotFoundException;
        return Failure(message: exception.message);
      case ServerErrorException:
        exception as ServerErrorException;
        return Failure(message: exception.body);
      case ClientErrorException:
        exception as ClientErrorException;
        return Failure(message: exception.body);
      case FormatException:
        exception as FormatException;
        return Failure(message: exception.message);
      case ClientException:
        exception as ClientException;
        return Failure(message: exception.message);
      default:
        return Failure(message: getIt<Configuration>().defaultErrorMessage);
    }
  }
}
