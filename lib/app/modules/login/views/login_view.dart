import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../registration/controllers/registration_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
   LoginView({super.key});
   final _registrationsController=Get.put(RegistrationController());
   final _emailController = TextEditingController(text: "robiul@e.com");
   final _passwordController = TextEditingController(text: "12345678");
   final _formKey = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text('Login')),
       body: Padding(
         padding: EdgeInsets.all(20),
         child: Form(
           key: _formKey,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Lottie.asset( "assets/img/login.json",height: 250),
               TextFormField(
                 controller: _emailController,
                 decoration: InputDecoration(
                   labelText: 'Email',
                   prefixIcon: Icon(Icons.email),
                   border: OutlineInputBorder(),
                 ),
                 validator: (value) {
                   if (value == null || value.isEmpty) return 'Enter email';
                   if (!value.isEmail) return 'Enter valid email';
                   return null;
                 },
               ),
               SizedBox(height: 20),
               TextFormField(
                 controller: _passwordController,
                 obscureText: true,
                 decoration: InputDecoration(
                   labelText: 'Password',
                   prefixIcon: Icon(Icons.lock),
                   border: OutlineInputBorder(),
                 ),
                 validator: (value) {
                   if (value == null || value.isEmpty) return 'Enter password';
                   if (value.length < 6) return 'Password too short';
                   return null;
                 },
               ),
               SizedBox(height: 30),
               Obx(() => _registrationsController.isLoggedIn.value
                   ? CircularProgressIndicator()
                   : ElevatedButton(
                 onPressed: _login,
                 style: ElevatedButton.styleFrom(
                   minimumSize: Size(double.infinity, 50),
                 ),
                 child: Text('Login'),
               ),
               ),
               TextButton(
                 onPressed: () => Get.toNamed(Routes.REGISTRATION),
                 child: Text('Create Account'),
               ),
             ],
           ),
         ),
       ),
     );
   }

   void _login() async {
     if (_formKey.currentState!.validate()) {

       try {
         final success = await _registrationsController.login(
           _emailController.text.trim(),
           _passwordController.text.trim(),

         );
         if (success) {
           try {
             final SharedPreferences prefs = await SharedPreferences.getInstance();
             await prefs.setString('email', _emailController.text.trim());
             final String? email = prefs.getString('email');
             print("Saved email: $email");
           } on PlatformException catch (e) {
             print("PlatformException: ${e.message}");
             Get.snackbar('Error', 'Failed to save preferences. Restart the app.');
           } catch (e) {
             print("General Error: $e");
           }
           Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);
         } else {
           throw 'Invalid credentials';
         }
       } catch (e) {
         print("error");
         print(e);
         Get.snackbar('Error', e.toString());
       }
       }
     }
   }


