sealed class Result<T> {
  const Result();

  factory Result.success(T data) = Success<T>;
  factory Result.failure(AppException exception) = Failure<T>;
  factory Result.error(AppException exception) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).value : null;
  AppException? get exception => this is Failure<T> ? (this as Failure<T>).error : null;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(AppException exception) onFailure,
  ) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).value);
    } else {
      return onFailure((this as Failure<T>).error);
    }
  }

  R when<R>({
    required R Function(T data) data,
    required R Function(AppException exception) error,
  }) {
    return fold(data, error);
  }
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final AppException error;
  const Failure(this.error);
}

class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class ServerException extends AppException {
  ServerException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class CacheException extends AppException {
  CacheException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}

class AuthException extends AppException {
  AuthException(String message, {String? code, dynamic originalError})
      : super(message, code: code, originalError: originalError);
}
