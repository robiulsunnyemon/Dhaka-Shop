import 'package:get/get.dart';

import '../../../data/model/product_model.dart';

class ProductDetailsController extends GetxController {
  late final Product product;
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;
  }
}
