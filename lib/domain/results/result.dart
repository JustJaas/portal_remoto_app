import 'package:rick_morty_app/domain/errors/api_exception.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.error);

  final ApiException error;
}
