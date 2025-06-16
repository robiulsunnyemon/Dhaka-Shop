// lib/controllers/cart_controller.dart

import 'package:get/get.dart';

import '../../../data/model/cart_item.dart';
import '../../../data/model/product_model.dart';




class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get totalAmount => cartItems.fold(
    0,
        (sum, item) => sum + (item.product.price * item.quantity.value),
  );

  void addToCart(Product product) {
    final existingItemIndex = cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (existingItemIndex >= 0) {
      cartItems[existingItemIndex].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
    cartItems.refresh();
  }

  void removeFromCart(Product product) {
    final existingItemIndex = cartItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (existingItemIndex >= 0) {
      if (cartItems[existingItemIndex].quantity > 1) {
        cartItems[existingItemIndex].quantity--;
      } else {
        cartItems.removeAt(existingItemIndex);
      }
    }
    cartItems.refresh();
  }

  void removeItem(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    cartItems.refresh();
  }

  void clearCart() {
    cartItems.clear();
  }

  bool isProductInCart(Product product) {
    return cartItems.any((item) => item.product.id == product.id);
  }


}