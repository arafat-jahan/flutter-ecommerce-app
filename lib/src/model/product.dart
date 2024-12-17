class Product {
  int id;
  String name;
  String category;
  String image;
  double price;
  bool isLiked; // Correct field name
  bool isSelected;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.isLiked = false, // Default value
    this.isSelected = false,
    required this.image,
  });

  // Optionally, you can add a copyWith method to make it easier to update isLiked or other fields
  Product copyWith({
    bool? isLiked,
    bool? isSelected,
  }) {
    return Product(
      id: this.id,
      name: this.name,
      category: this.category,
      price: this.price,
      image: this.image,
      isLiked: isLiked ?? this.isLiked,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
