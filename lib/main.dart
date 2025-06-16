import 'package:device_preview/device_preview.dart';
import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:dhaka_shop/app/theme/dark_theme/dark_theme.dart';
import 'package:dhaka_shop/app/theme/light_theme/light_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/order_history/controllers/order_history_controller.dart';
import 'app/modules/registration/controllers/registration_controller.dart';
import 'app/modules/wishlist/controllers/wishlist_controller.dart';
import 'app/theme/controller/theme_controller.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dhaka Shop',
      theme: ThemeController.to.lightTheme,
      darkTheme: ThemeController.to.darkTheme,
      themeMode: ThemeController.to.themeMode,
      getPages: AppPages.routes,
      initialRoute: Routes.SPLASH,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
    );
  }
}
