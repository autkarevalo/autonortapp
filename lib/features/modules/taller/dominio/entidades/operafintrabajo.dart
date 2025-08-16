class Operafintrabajo {
  final String status;
  final String? message;

  Operafintrabajo({
    required this.status,
    this.message,
  });

  bool get isSuccess => status.toLowerCase() == 'success';
}
