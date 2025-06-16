import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import '../../../components/product_card_widget.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  WishlistView({super.key});
  final HomeController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () => _showClearConfirmationDialog(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.wishlistItems.isEmpty) {
          return _buildEmptyWishlist();
        }
        return _buildWishlistGrid();
      }),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Your wishlist is empty'.tr,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Get.toNamed(Routes.BOTTOM_NAVIGATION_BAR),
            child: Text('Browse Products'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: controller.wishlistItems.length,
      itemBuilder: (context, index) {
        final wishlistItem = controller.wishlistItems[index];
        final product = wishlistItem.product;

        return ProductCard(
          product: product,
        );
      },
    );
  }

  void _showClearConfirmationDialog() {
    Get.defaultDialog(
      title: 'Clear Wishlist'.tr,
      content: Text('Are you sure you want to clear your wishlist?'.tr),
      confirm: ElevatedButton(
        onPressed: () {
          controller.clearWishList();
          Get.back();
        },
        child: Text('Yes'.tr),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text('No'.tr),
      ),
    );
  }
}