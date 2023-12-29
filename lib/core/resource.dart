abstract class Resource<T> {
  const Resource();

  factory Resource.loading() = Loading<T>;
  factory Resource.success(T data) = Success<T>;
  factory Resource.error(dynamic message) = Error<T>;

  R when<R>({
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    if (this is Loading<T>) {
      return loading();
    } else if (this is Success<T>) {
      return success((this as Success<T>).data);
    } else if (this is Error<T>) {
      return error((this as Error<T>).message);
    } else {
      throw ArgumentError('Unknown resource type');
    }
  }
}

class Loading<T> extends Resource<T> {
  const Loading();
}

class Success<T> extends Resource<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends Resource<T> {
  final dynamic message;

  const Error(this.message);
}
