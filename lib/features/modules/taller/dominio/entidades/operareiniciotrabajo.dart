class Operareiniciotrabajo {
  final String status;
  final String? message;

  Operareiniciotrabajo({
    required this.status,
    this.message,
  });

  bool get isSuccess => status.toLowerCase() == 'success';

}