class BaseModel<T> {
  final bool success;
  final String? message;
  final T? data;

  BaseModel({
    required this.success,
    this.message,
    this.data,
  });
}
