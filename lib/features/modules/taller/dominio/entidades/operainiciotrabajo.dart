class Operainiciotrabajo {
  final String status;
  final String? message;

  Operainiciotrabajo({
    required this.status,
    this.message,
  });

  bool get isSuccess => status.toLowerCase() == 'success';
}