class Product {
  final String title;
  final String price;
  final String img;

  Product({
    required this.title,
    required this.price,
    required this.img,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      title: data["title"],
      price: data["price"],
      img: data["img"],
    );
  }
}
