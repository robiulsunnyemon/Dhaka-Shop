
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/controller/theme_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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