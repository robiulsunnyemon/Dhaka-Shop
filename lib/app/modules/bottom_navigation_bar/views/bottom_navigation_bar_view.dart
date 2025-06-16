import 'package:dhaka_shop/app/modules/cart/views/cart_view.dart';
import 'package:dhaka_shop/app/modules/category/views/category_view.dart';
import 'package:dhaka_shop/app/modules/home/views/home_view.dart';
import 'package:dhaka_shop/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_navigation_bar_controller.dart';

class BottomNavigationBarView extends GetView<BottomNavigationBarController> {
  const BottomNavigationBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentIndex.value,
        children: [
          HomeView(),
          CategoryView(),
          CartView(),
          ProfileView(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) => controller.changePage(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Categories'.tr,
          ),
          BottomNavigationBarItem(
            icon: Badge(
              backgroundColor: Colors.green,
              label: Obx(() => Text(
                '${controller.cartItemCount.value}',
                style: TextStyle(color: Colors.white),
              )),
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Cart'.tr,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'.tr,
          ),
        ],
      )),
    );
  }
}
