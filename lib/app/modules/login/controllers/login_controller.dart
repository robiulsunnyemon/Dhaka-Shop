import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../registration/controllers/registration_controller.dart';

class LoginController extends GetxController {
  final RegistrationController registrationController = Get.put(RegistrationController());

  Future<void> login(String email, String password) async {
    try {
      final success = await registrationController.login(email, password);
      if (success) {
        Get.offAllNamed('/home');
      } else {
        throw 'Invalid credentials';
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }



}


class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final auth = Get.find<RegistrationController>();
    return auth.isLoggedIn.value ? null : RouteSettings(name: '/login');
  }
}