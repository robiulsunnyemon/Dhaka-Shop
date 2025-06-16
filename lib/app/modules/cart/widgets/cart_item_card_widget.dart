import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/cart_item.dart';
import '../controllers/cart_controller.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
   CartItemCard({super.key, required this.item});
  final cartController=Get.find<CartController>();


  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item.product.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title),
                  Text('\$${item.product.price.toStringAsFixed(2)}'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => cartController.removeFromCart(item.product),
            ),
            Text('${item.quantity}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => cartController.addToCart(item.product),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => cartController.removeItem(item.product),
            ),
          ],
        ),
      ),
    );
  }
}