import '../core/errors/errors.dart';

class FailureModel {
  final Failure failure;
  final bool hasError;

  FailureModel({
    required this.failure,
    required this.hasError,
  });

  FailureModel copyWith() => FailureModel(
        failure: failure,
        hasError: hasError,
      );
  static FailureModel get empty => FailureModel(
        failure: Failure(message: ""),
        hasError: false,
      );

  static FailureModel get(Failure failure) => FailureModel(
        failure: failure,
        hasError: true,
      );
}
