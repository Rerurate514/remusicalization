class Result<T>{
  final bool isSucceeded;
  final T? value;
  final String errorMsg;

  Result({
    required this.isSucceeded,
    this.value,
    this.errorMsg = ""
  });
}
