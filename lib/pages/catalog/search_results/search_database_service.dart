import '../../../classes/post_class.dart';
import '../../../classes/product_class.dart';
import '../../../classes/user_class.dart';

class SearchDatabaseService {
  // For now, we'll use static lists to simulate a database
  static final List<Product> _products = [
    Product(
        id: '1',
        name: 'Product 1',
        imageUrl: 'https://picsum.photos/seed/1/600',
        price: 19.99,
        rating: 4.5),
    Product(
        id: '2',
        name: 'Product 2',
        imageUrl: 'https://picsum.photos/seed/2/600',
        price: 29.99,
        rating: 4.2),
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
