import 'package:dhaka_shop/app/data/model/product_model.dart';
import 'package:get/get.dart';

class CartItem {
  final Product product;
  var quantity = 1.obs;

  CartItem({required this.product});
}