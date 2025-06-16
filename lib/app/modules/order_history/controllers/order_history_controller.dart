import 'package:get/get.dart';

import '../../../data/model/order_product_model.dart';

class OrderHistoryController extends GetxController {
  final RxList<Order> _orders = <Order>[].obs;

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
  }
}
