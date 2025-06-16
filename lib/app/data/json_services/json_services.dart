// lib/services/product_service.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    try {
      // অ্যাসেটস থেকে JSON ডাটা লোড করুন
      final String response = await rootBundle.loadString('assets/products.json');

      // JSON ডাটা পার্স করুন
      final List<dynamic> data = json.decode(response);

      // প্রোডাক্ট লিস্টে কনভার্ট করুন
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print("Error loading products: $e");
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchFeaturedProducts() async {
    try {
      final String response = await rootBundle.loadString('assets/featured_products.json');

      final List<dynamic> data = json.decode(response);

      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print("Error loading products: $e");
      throw Exception('Failed to load products');
    }
  }
}