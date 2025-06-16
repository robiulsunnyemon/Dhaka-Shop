import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/order_history/controllers/order_history_controller.dart';
import 'app/modules/registration/controllers/registration_controller.dart';
import 'app/modules/wishlist/controllers/wishlist_controller.dart';
import 'app/theme/controller/theme_controller.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  Get.put(WishlistController());
  Get.put(OrderHistoryController());
  Get.put(RegistrationController());
  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.put(ThemeController());
  runApp(
    // const MyApp()
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

