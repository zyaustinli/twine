import '../../../classes/post_view_class.dart';
import '../../../classes/product_class.dart';
import '../../../classes/user_class.dart';

class SearchDatabaseService {
  // For now, we'll use static lists to simulate a database
  static final List<Product> _products = [
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
    // Add more products...
  ];

  static final List<Post> _posts = [
    Post(id: '1', imageUrl: 'https://picsum.photos/seed/101/600'),
    Post(id: '2', imageUrl: 'https://picsum.photos/seed/102/600'),
    // Add more posts...
  ];

  static final List<User> _users = [
    User(
        id: '1',
        username: 'User1',
        profileImageUrl: 'https://picsum.photos/seed/201/600'),
    User(
        id: '2',
        username: 'User2',
        profileImageUrl: 'https://picsum.photos/seed/202/600'),
    // Add more users...
  ];

  // Methods to retrieve data
  Future<List<Product>> getProducts({String? searchQuery}) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    return _products;
  }

  Future<List<Post>> getPosts() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    return _posts;
  }

  Future<List<User>> getUsers({String? searchQuery}) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));

    return _users;
  }

  // You can add more methods here for other operations like adding, updating, or deleting data
}
