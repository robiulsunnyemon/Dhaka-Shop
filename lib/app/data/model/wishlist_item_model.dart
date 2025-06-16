import 'package:dhaka_shop/app/data/model/product_model.dart';

class WishlistItem {
  final String id;
  final Product product; // সরাসরি Product অবজেক্ট স্টোর করুন
  final DateTime addedAt;

  WishlistItem({
    required this.id,
    required this.product,
    required this.addedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'product': product.toJson(), // Product কে JSON এ কনভার্ট করুন
    'addedAt': addedAt.toIso8601String(),
  };

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
    id: json['id'],
    product: Product.fromJson(json['product']), // JSON থেকে Product তৈরি করুন
    addedAt: DateTime.parse(json['addedAt']),
  );
}