import 'dart:async';

import 'package:flutter/widgets.dart';

class InactividadServices with WidgetsBindingObserver {
  final Duration timeoutDuration;
  final VoidCallback onTimeout;
  Timer? _inactivityTimer;

  InactividadServices({required this.timeoutDuration, required this.onTimeout});

  void start() {
    _resetTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  void stop() {
    _inactivityTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(timeoutDuration, onTimeout);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _resetTimer();
    }
  }

  void userInterationDetected() {
    _resetTimer();
  }
}
