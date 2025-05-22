import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServices {
  /// True si hay al menos UNA interfaz conectada (Wi-Fi o móvil).
  Future<bool> hasNetwork() async {
    final results = await Connectivity().checkConnectivity();
    // Devuelve true si existe al menos un tipo de conexión distinto a 'none'
    return results.any((r) => r != ConnectivityResult.none);
  }
}
