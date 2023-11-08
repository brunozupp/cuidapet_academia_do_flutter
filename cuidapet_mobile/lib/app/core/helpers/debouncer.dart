import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {

  final int milliseconds;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
  });

  void run(VoidCallback action) {

    // Se eu já tiver um timer ativo, vou cancelar ele e colocar um novo
    if(_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}