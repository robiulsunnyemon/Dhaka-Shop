import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  // User data observables
  var name = 'Robiul Sunny Emon'.obs;
  var email = ''.obs;
  var avatarUrl = 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'.obs;
  final Rx<File?> profileImageFile = Rx<File?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      email.value = prefs.getString('email') ?? "demo";
      await loadProfilePicture(); // Load profile picture during initialization
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
      Get.snackbar('Error', 'Failed to load preferences. Restart the app.');
    } catch (e) {
      print("General Error: $e");
    }
  }

  // Function to update profile
  Future<void> updateProfile(String newName, String newEmail, String newAvatarUrl) async {
    name.value = newName;
    email.value = newEmail;
    avatarUrl.value = newAvatarUrl;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', newEmail);
    } catch (e) {
      print('Error saving profile data: $e');
    }
  }

  Future<void> loadProfilePicture() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. Check for local file path first
      final String? savedPath = prefs.getString('profilePicturePath');
      if (savedPath != null && File(savedPath).existsSync()) {
        profileImageFile.value = File(savedPath);
        return;
      }

      // 2. If no local file, check for remote URL
      final String? savedUrl = prefs.getString('profilePictureUrl');
      if (savedUrl != null && savedUrl.isNotEmpty) {
        avatarUrl.value = savedUrl;
      }

    } catch (e) {
      print('Error loading profile picture: $e');
      // Fallback to default avatar
      avatarUrl.value = 'https://example.com/default-avatar.jpg';
    }
  }

  Future<void> saveProfilePicture(String imagePath) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePicturePath', imagePath);
      profileImageFile.value = File(imagePath);
    } catch (e) {
      print('Error saving profile picture: $e');
      rethrow;
    }
  }

  Future<void> saveProfilePictureUrl(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profilePictureUrl', url);
      avatarUrl.value = url;
    } catch (e) {
      print('Error saving profile picture URL: $e');
      rethrow;
    }
  }
}