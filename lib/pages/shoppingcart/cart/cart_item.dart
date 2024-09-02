class CartItem {
  final int productID;
  final String image;
  final String brandName;
  final String productName;
  final double price;
  final String size;
  final String color;
  final double discount;
  int quantity;

  CartItem({
    required this.productID,
    required this.image,
    required this.brandName,
    required this.productName,
    required this.price,
    required this.size,
    required this.color,
    required this.discount,
    this.quantity = 1,
  });
}