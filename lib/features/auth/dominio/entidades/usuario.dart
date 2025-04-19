class Usuario {
  final String id;
  final String nombre;
  final String idempresa;
  final bool? esinvitado; // Opcional (solo lo tendrás al hacer login)
  final String? token;     // Opcional (solo lo tendrás al hacer login)
  final int? iat;          // Opcional (solo en checkAuth)
  final int? exp;          // Opcional (solo en checkAuth)

  Usuario({
    required this.id,
    required this.nombre,
    required this.idempresa,
    this.esinvitado,
    this.token,
    this.iat,
    this.exp,
  });

  factory Usuario.fromLoginJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      idempresa: json['idempresa'],
      esinvitado: json['esinvitado'],
      token: json['token'],
    );
  }

  factory Usuario.fromCheckJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      idempresa: json['idempresa'],
      iat: json['iat'],
      exp: json['exp'],
    );
  }
}