import 'package:dhaka_shop/app/modules/home/controllers/home_controller.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
   CategoryView({super.key});
  final HomeController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: Obx(() {

        final categories = productController.productList
            .map((product) => product.category)
            .toSet()
            .toList();

        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index]),
              onTap: () {
                Get.toNamed(Routes.CATEGORY_PRODUCTS, arguments: categories[index]);
              },
            );
          },
        );
      }),
    );
  }
}
