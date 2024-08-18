import 'package:flutter/material.dart';
import '../pages/profile/create_outfit/database_outfit.dart';
import '../pages/profile/create_outfit/product_class.dart';

class CreateOutfitSearchModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();
  List<Product> searchResults = [];
  bool isLoading = false;

  Future<void> searchProducts(String query) async {
    isLoading = true;
    notifyListeners();

    searchResults = await _databaseService.searchProducts(query);

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadInitialProducts() async {
    isLoading = true;
    notifyListeners();

    searchResults = await _databaseService.getProducts();

    isLoading = false;
    notifyListeners();
  }

  void onUpdate() {
    notifyListeners();
  }

  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();
  }
}