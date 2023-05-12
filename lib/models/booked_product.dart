class BookedProduct {
  final String title;
  final String img;
  final int count;
  final String price;

  BookedProduct({
    required this.title,
    required this.img,
    required this.count,
    required this.price,
  });

  factory BookedProduct.fromMap(Map<String, dynamic> data) {
    return BookedProduct(
      title: data["title"],
      img: data["img"],
      count: data["count"],
      price: data["price"],
    );
  }
}
