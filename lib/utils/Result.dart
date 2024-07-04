class Result<T>{
  final bool isSucceeded;
  final T? value;
  final String errorMsg;

  const Result({
    required this.isSucceeded,
    this.value,
    this.errorMsg = ""
  });
}
