import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    this.id,
    this.title,
    this.description,
    this.image,
    this.categoryId,
    this.oldPrice,
    this.price,
    this.quantity,
    this.available,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? '',
      description: json['description'] as String ?? '',
      image: json['image'] as String ?? '',
      categoryId: json['category_id'] as int ?? 0,
      oldPrice: json['old_price'] as int ?? 0,
      price: json['price'] as int ?? null,
      quantity: json['quantity'] as String ?? '',
      available: json['available'] as int ?? 0,
    );
  }

  final int id;
  final String title;
  final int categoryId;
  final String quantity;
  final String description;
  final String image;
  final int oldPrice;
  final int price;
  final int available;

  @override
  List<Object> get props => [this.id];
}
