class Operaparalizatrabajo {
  final String status;
  final String? message;

  Operaparalizatrabajo({
    required this.status,
    this.message,
  });

  bool get isSuccess => status.toLowerCase() == 'success';
}
