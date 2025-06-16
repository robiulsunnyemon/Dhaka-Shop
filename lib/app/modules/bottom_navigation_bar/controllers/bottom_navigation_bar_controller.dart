import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../order_history/controllers/order_history_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class BottomNavigationBarController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt cartItemCount = 0.obs;
  final RxInt wishlistItemCount = 0.obs;

  final CartController _cartController = Get.find();
  final WishlistController _wishlistController = Get.find();

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _setupListeners();
    _updateInitialCounts();
  }

  void _initializeControllers() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => WishlistController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => OrderHistoryController());
  }

  void _setupListeners() {
    ever(_cartController.cartItems, (_) => updateCartCount());
    ever(_wishlistController.wishlistItems, (_) => updateWishlistCount());
  }

  void _updateInitialCounts() {
    updateCartCount();
    updateWishlistCount();
  }

  void changePage(int index) {
    currentIndex.value = index;
  }

  void updateCartCount() {
    cartItemCount.value = _cartController.cartItems.fold(
      0,
          (sum, item) => sum + item.quantity.value,
    );
  }

  void updateWishlistCount() {
    wishlistItemCount.value = _wishlistController.wishlistItems.length;
  }
}
