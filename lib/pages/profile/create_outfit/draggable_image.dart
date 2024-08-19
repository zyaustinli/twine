import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DraggableImage {
  final String url;
  Offset position;
  ui.Image? image;
  List<List<bool>>? hitMap;
  DraggableImage(this.url, this.position);
}