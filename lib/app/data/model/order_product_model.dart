import 'cart_item.dart';

class Order {
  final String id;
  final String name;
  final String phone;
  final String address;
  final double totalAmount;
  final DateTime orderDate;
  final List<CartItem> items;

  Order({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.items,
    DateTime? orderDate,
  }) : orderDate = orderDate ?? DateTime.now();
}