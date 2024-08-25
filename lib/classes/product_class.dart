class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double rating;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  // This will be useful when we transition to Firebase
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }
}
