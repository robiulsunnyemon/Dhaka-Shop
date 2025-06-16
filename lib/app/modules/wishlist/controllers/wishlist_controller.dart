// lib/controllers/wishlist_controller.dart
import 'package:get/get.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/wishlist_item_model.dart';


class WishlistController extends GetxController {
  final wishlistItems = <WishlistItem>[].obs;

  @override
  void onInit() {
    super.onInit();
  }




  void toggleWishlist(Product product) {

    final existingIndex = wishlistItems.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      wishlistItems.removeAt(existingIndex);
      Get.snackbar(
        'Removed',
        '${product.title} removed from wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      wishlistItems.add(
        WishlistItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          product: product,
          addedAt: DateTime.now(),
        ),
      );
      Get.snackbar(
        'Added',
        '${product.title} added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

  }

  void removeFromWishlist(String wishlistItemId) {
    wishlistItems.removeWhere((item) => item.id == wishlistItemId);
  }

  bool isWishListed(Product product){
    final existingIndex = wishlistItems.indexWhere((item) => item.product.id == product.id);
    if(existingIndex>=0){
      return true;
    }else{
      return false;
    }
  }

  void clearWishList(){
    wishlistItems.clear();
    update();
  }
}

