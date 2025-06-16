import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.orders.length,
        itemBuilder: (context, index) {
          final order = controller.orders[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order #${order.id}', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Date: ${ DateFormat('dd-MM-yyyy HH:mm').format(order.orderDate)}'),
                  Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...order.items.map((item) =>
                      Text('- ${item.product.title} x${item.quantity}')
                  ).toList(),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
