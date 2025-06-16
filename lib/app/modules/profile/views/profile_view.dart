import 'dart:io';

import 'package:dhaka_shop/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Profile'),
              pinned: true,
              backgroundColor: Colors.transparent,
              actions: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: .4),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(context),
                  ),
                ),
                SizedBox(width: 8),
              ],
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: GestureDetector(
                  onTap: _changeProfilePicture,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          controller.avatarUrl.value,
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                collapseMode: CollapseMode
                    .pin, // Keeps the rounded corners when collapsing
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        controller.name.value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(controller.email.value),
                      const SizedBox(height: 24),
                      _buildProfileOption(
                        icon: Icons.history,
                        title: 'My Orders',
                        onTap: () => Get.toNamed(Routes.ORDER_HISTORY),
                      ),
                      _buildProfileOption(
                        icon: Icons.location_on,
                        title: 'Delivery Address',
                        onTap: () => Get.toNamed('/addresses'),
                      ),
                      _buildProfileOption(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () => Get.toNamed('/settings'),
                      ),
                      _buildProfileOption(
                        icon: Icons.favorite_outline,
                        title: 'Wishlist',
                        onTap: () => Get.toNamed(Routes.WISHLIST),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 300)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: controller.name.value);
    final emailController = TextEditingController(text: controller.email.value);

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          // Added scroll for small screens
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: 'Name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.updateProfile(
                nameController.text,
                emailController.text,
                controller.avatarUrl.value,
              );
              Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();

    final option = await Get.bottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.green),
              title: const Text('Take Photo',style: TextStyle(color: Colors.grey),),
              onTap: () {
                Get.back(result: 'camera');
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text('Choose from Gallery',style: TextStyle(color: Colors.grey),),
              onTap: () {
                Get.back(result: 'gallery');
              },
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );

    try {
      if (option == 'camera') {
        final XFile? image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
          maxWidth: 800,
        );
        if (image != null) {
          _uploadProfilePicture(File(image.path));
        }
      } else if (option == 'gallery') {
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
          maxWidth: 800,
        );
        if (image != null) {
          controller.saveProfilePicture(image.path);
          _uploadProfilePicture(File(image.path));
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to select image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _uploadProfilePicture(File imageFile) async {
    try {
      // Show loading indicator
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Here you would typically upload to your server
      // For demo, we'll just update locally after a delay
      await Future.delayed(const Duration(seconds: 2));

      // Update the avatar URL in controller
      controller.avatarUrl.value = imageFile.path;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePictureUrl', imageFile.path);

      Get.back(); // Close loading dialog
      Get.snackbar(
        'Success',
        'Profile picture updated',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar(
        'Error',
        'Failed to upload image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
