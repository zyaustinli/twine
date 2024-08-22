import 'dart:async';
import 'product_class.dart';

class DatabaseService {
  // This list simulates our database
  final List<Product> _products = [
    Product(
        id: '1',
        name: 'T-Shirt',
        imageUrl:
            'https://madeblanks.com/cdn/shop/products/HOMEROOMT-SHIRTPHANTOMBLACK_0122_WEB.png?v=1711996848&width=1946',
        price: 19.99,
        rating: 4.5),
    Product(
        id: '2',
        name: 'Jeans',
        imageUrl:
            'https://media.vogue.co.uk/photos/62d96820171efe2b9a595125/3:4/w_748%2Cc_limit/3.png',
        price: 49.99,
        rating: 4.2),
    Product(
        id: '3',
        name: 'Sneakers',
        imageUrl:
            'https://images.ctfassets.net/hnk2vsx53n6l/34QZZB5PserSDsXOU5LyaQ/956e197c9a7b37387c12557fe3e203d7/u1i7qaoi1txiumt8jzps.png?fm=webp',
        price: 79.99,
        rating: 4.7),
    Product(
        id: '4',
        name: 'Hoodie',
        imageUrl:
            'https://bearbottomclothing.com/cdn/shop/files/OversizedHoodieMochaFlat1.png?v=1707247764&width=1080',
        price: 39.99,
        rating: 4.4),
  ];

  Future<List<Product>> searchProducts(String query) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    if (query.isEmpty) {
      return _products;
    }

    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // This method will be useful when we transition to Firebase
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _products;
  }
}
