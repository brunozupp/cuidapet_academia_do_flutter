import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';

class CuidapetLoader {

  static OverlayEntry? _entry;
  static bool _open = false;

  CuidapetLoader._();

  static void show() {
    _entry ??= OverlayEntry(builder: (context) {
      return Container(
        color: Colors.black54,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });

    if(!_open) {
      _open = true;
      Asuka.addOverlay(_entry!);
    }
  }

  static void hide() {
    if(_open) {
      _open = false;
      _entry?.remove();
    }
  }
}