class DoubleResponse<T, R> {
  DoubleResponse(
    this.data1,
    this.data2,
  );
  final T? data1;
  final R? data2;

  DoubleResponse<T, R> copyWith({
    T? data1,
    R? data2,
  }) {
    return DoubleResponse<T, R>(
      data1 ?? this.data1,
      data2 ?? this.data2,
    );
  }
}
class DataResponse {
  final String? error;
  final dynamic data;

  bool get hasData => data != null;

  bool get hasError => error != null;

  DataResponse({
    this.error,
    this.data,
  });
}
