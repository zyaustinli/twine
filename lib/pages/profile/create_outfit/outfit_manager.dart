import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'create_outfit_widget.dart' show DraggableImage;
import 'package:flutter/material.dart';


class Outfit {
  final List<PlacedProduct> products;
  final Color backgroundColor;
  final String imagePath;

  Outfit({
    required this.products,
    required this.backgroundColor,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
    'products': products.map((p) => p.toJson()).toList(),
    'backgroundColor': backgroundColor.value,
    'imagePath': imagePath,
  };

  factory Outfit.fromJson(Map<String, dynamic> json) => Outfit(
    products: (json['products'] as List).map((p) => PlacedProduct.fromJson(p)).toList(),
    backgroundColor: Color(json['backgroundColor'] as int),
    imagePath: json['imagePath'] as String,
  );
}

class PlacedProduct {
  final String productId;
  final String imageUrl;
  final Offset position;
  final double scale;

  PlacedProduct({required this.productId, required this.imageUrl, required this.position, required this.scale});

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'imageUrl': imageUrl,
    'position': {'dx': position.dx, 'dy': position.dy},
    'scale': scale,
  };

  factory PlacedProduct.fromJson(Map<String, dynamic> json) => PlacedProduct(
    productId: json['productId'] as String,
    imageUrl: json['imageUrl'] as String,
    position: Offset(json['position']['dx'] as double, json['position']['dy'] as double),
    scale: json['scale'] as double,
  );
}

class OutfitManager {
  static List<Outfit> outfits = [];

  static Future<void> saveOutfit(List<DraggableImage> images, Color backgroundColor, GlobalKey stackKey) async {
    final RenderRepaintBoundary boundary = stackKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/outfit_${DateTime.now().millisecondsSinceEpoch}.png';
    await File(path).writeAsBytes(pngBytes);

    final placedProducts = images.map((img) => PlacedProduct(
      productId: img.productId,
      imageUrl: img.url,
      position: img.position,
      scale: img.scale,
    )).toList();

    final outfit = Outfit(
      products: placedProducts,
      backgroundColor: backgroundColor,
      imagePath: path,
    );

    outfits.add(outfit);
    await _saveOutfitsToFile();
  }

  static Future<void> _saveOutfitsToFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/outfits.json');
    final jsonString = json.encode(outfits.map((o) => o.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  static Future<void> loadOutfits() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/outfits.json');
    if (await file.exists()) {
      final jsonString = await file.readAsString();
      final jsonList = json.decode(jsonString) as List;
      outfits = jsonList.map((json) => Outfit.fromJson(json)).toList();
    }
  }
}