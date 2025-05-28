import 'package:autonort/config/config.dart';
import 'package:autonort/features/home/dominio/dominio.dart';
import 'package:autonort/features/home/infraestructura/infraestructura.dart';

class HomeDatasourceImpl extends HomeDatasource {
  final HttpService http = HttpService();

  @override
  Future<Home> tutorial(String codempreda) async {
    final result = await http.get('/app/home/$codempreda');
    return result.fold((failure) => throw CustomError(failure.message),
        (response) => HomeMapper.fromJson(response.data as Map<String, dynamic>));
  }
}
