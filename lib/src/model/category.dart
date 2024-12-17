class Category {
  int? id;            // Nullable integer
  String? name;       // Nullable string
  String? image;      // Nullable string
  bool isSelected;    // Non-nullable, default value provided

  Category({
    this.id,
    this.name,
    this.image,
    this.isSelected = false, // Default value for isSelected
  });
}
